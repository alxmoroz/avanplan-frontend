// Copyright (c) 2022. Alexandr Moroz

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart' hide Interceptor;

import '../../../L2_data/services/api.dart';
import '../../../L2_data/services/platform.dart';
import '../../components/button.dart';
import '../../components/images.dart';
import '../../extra/services.dart';
import '../../presenters/communications.dart';

part 'loader_controller.g.dart';

class LoaderController = _LoaderControllerBase with _$LoaderController;

abstract class _LoaderControllerBase with Store {
  @observable
  String? imageName;

  @observable
  String? titleText;

  @observable
  String? descriptionText;

  @observable
  Widget? actionWidget;

  @observable
  int _stack = 0;

  @observable
  bool _init = true;

  @computed
  bool get loading => _stack > 0 || _init;

  @action
  void start() => _stack++;

  @action
  void set({
    String? titleText,
    String? descriptionText,
    String? imageName,
    String? actionText,
    Widget? action,
  }) {
    action ??= actionText != null ? _stopAction(actionText) : null;
    this.imageName = imageName;
    this.titleText = titleText;
    this.descriptionText = descriptionText;
    actionWidget = action;
  }

  @action
  Future stop([int? milliseconds]) async => await Future<void>.delayed(Duration(milliseconds: milliseconds ?? 0), () => --_stack);

  @action
  void _reset() => _stack = 0;

  @action
  void stopInit() => _init = false;

  /// Interceptor
  Interceptor get interceptor => InterceptorsWrapper(onError: (e, handler) async {
        if (e.type == DioExceptionType.badResponse) {
          final code = e.response?.statusCode ?? 666;
          final path = e.requestOptions.path;

          if ([401, 403, 407].contains(code)) {
            // ошибки авторизации
            if (path.startsWith('/v1/auth/password_token')) {
              // Показываем диалог, если это именно авторизация
              setAuthError();
            } else if (e.errCode.startsWith('ERR_PERMISSION_LIMIT')) {
              // Показываем диалог ограничений тарифа
              _setTariffLimitError();
            } else if (e.errCode.startsWith('ERR_PERMISSION')) {
              // Показываем диалог отсутствия прав
              _setPermissionError();
            } else if (e.errCode.startsWith('ERR_AUTH_INVITATION')) {
              _setRedeemInvitationError();
            } else {
              // в остальных случаях выбрасываем без объяснений
              await authController.signOut();
              _reset();
              return;
            }
          } else {
            // программные ошибки сервера
            final errorText = '${code < 500 ? 'HTTP Client' : code < 600 ? 'HTTP Server' : 'Unknown HTTP'} Error $code';
            if (e.errCode.startsWith('ERR_IMPORT')) {
              _setImportError(e.detail, e.detail);
            } else {
              _setHTTPError(errorText, e.detail);
            }
          }
        } else {
          if (e.error is SocketException) {
            try {
              _setNetworkError('${e.error}');
            } catch (_) {
              if (kDebugMode) {
                print('SocketException $e');
              }
              set(
                titleText: 'SocketException',
                descriptionText: '$e',
                action: Container(),
              );
            }
          }
        }
        if (!loading) {
          return handler.next(e);
        }
      });

  Widget _stopAction(String actionText) => MTButton.main(
        titleText: actionText,
        onTap: stop,
      );

  void _setHTTPError(String? errorText, String? errorDetail) {
    errorText ??= 'LoaderHTTPError';
    final mainRecommendationText = isWeb ? loc.update_web_app_recommendation_title : loc.update_app_recommendation_title;
    set(
      imageName: ImageName.server_error.name,
      titleText: errorText,
      descriptionText: mainRecommendationText,
      action: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _stopAction(loc.ok),
          ReportErrorButton('$errorText ${errorDetail ?? ''}'),
        ],
      ),
    );
  }

  void _setNetworkError(String? errorText) => set(
        imageName: ImageName.network_error.name,
        titleText: loc.error_network_title,
        descriptionText: loc.error_network_description,
        action: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _stopAction(loc.ok),
            ReportErrorButton(errorText ?? 'LoaderNetworkError'),
          ],
        ),
      );

  void setAuthError([String? description]) => set(
        imageName: ImageName.privacy.name,
        titleText: loc.error_auth_title,
        descriptionText: description != null ? Intl.message('error_auth_$description') : loc.error_auth_description,
        actionText: loc.ok,
      );

  void _setPermissionError([String? description]) => set(
        imageName: ImageName.privacy.name,
        titleText: loc.error_permission_title,
        descriptionText: description != null ? Intl.message('error_permission_$description') : loc.error_permission_description,
        actionText: loc.ok,
      );

  void _setTariffLimitError([String? description]) => set(
        imageName: ImageName.privacy.name,
        titleText: loc.error_tariff_limit_title,
        descriptionText: description != null ? Intl.message('error_tariff_limit_$description') : loc.error_tariff_limit_description,
        actionText: loc.ok,
      );

  void _setRedeemInvitationError() => set(
        imageName: ImageName.privacy.name,
        titleText: loc.error_redeem_invitation_title,
        descriptionText: loc.error_redeem_invitation_description,
        actionText: loc.ok,
      );

  // TODO: разнести публичные методы по соотв. вьюхам / контроллерам / презентерам

  void setCheckConnection(String descriptionText) => set(
        imageName: ImageName.sync.name,
        titleText: loc.loader_check_connection_title,
        descriptionText: descriptionText,
      );
  void setDeleting() => set(titleText: loc.loader_deleting_title, imageName: ImageName.delete.name);
  void setImporting(String descriptionText) => set(
        titleText: loc.loader_importing_title,
        descriptionText: descriptionText,
        imageName: ImageName.import.name,
      );
  void _setImportError(String? descriptionText, String? errorDetail) => set(
        titleText: loc.error_import_title,
        descriptionText: descriptionText,
        imageName: ImageName.import.name,
        action: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _stopAction(loc.ok),
          ReportErrorButton('$descriptionText ${errorDetail ?? ''}'),
        ]),
      );
  void setLoading() => set(titleText: loc.loader_refreshing_title, imageName: ImageName.loading.name);
  void setSaving() => set(titleText: loc.loader_saving_title, imageName: ImageName.save.name);
  void setSourceListing(String descriptionText) => set(
        titleText: loc.loader_source_listing,
        descriptionText: descriptionText,
        imageName: ImageName.import.name,
      );
  void setUnlinking() => set(titleText: loc.loader_unlinking_title, imageName: ImageName.transfer.name);
}
