// Copyright (c) 2022. Alexandr Moroz

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart' hide Interceptor;
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L2_data/repositories/api.dart';
import '../../../L2_data/repositories/platform.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/communications_presenter.dart';

part 'loader_controller.g.dart';

class LoaderController = _LoaderControllerBase with _$LoaderController;

abstract class _LoaderControllerBase with Store {
  @observable
  Widget? iconWidget;

  @observable
  Widget? titleWidget;

  @observable
  Widget? descriptionWidget;

  @observable
  Widget? actionWidget;

  @observable
  int stack = 0;

  @action
  void start() => stack++;

  @action
  void _set({
    String? titleText,
    Widget? title,
    String? descriptionText,
    Widget? description,
    Widget? icon,
    String? actionText,
    Widget? action,
  }) {
    iconWidget = icon ?? _defaultIcon;
    titleWidget = title ?? (titleText != null ? _title(titleText) : null);
    descriptionWidget = description ?? (descriptionText != null ? _description(descriptionText) : null);
    actionWidget = action ?? (actionText != null ? _stopAction(actionText) : null);
  }

  @action
  Future stop([int? milliseconds]) async => await Future<void>.delayed(Duration(milliseconds: milliseconds ?? 0), () => --stack);

  /// Interceptor
  Interceptor get interceptor => InterceptorsWrapper(onError: (e, handler) async {
        if (e.type == DioErrorType.other) {
          if (e.error is SocketException) {
            _setNetworkError('${e.error}');
          }
        } else if (e.type == DioErrorType.response) {
          final code = e.response?.statusCode ?? 666;
          final path = e.requestOptions.path;

          if ([401, 403, 407].contains(code)) {
            // ошибки авторизации
            if (path.startsWith('/v1/auth')) {
              // Показываем диалог, если это именно авторизация
              setAuthError();
            } else {
              // в остальных случаях выбрасываем без объяснений
              await authController.signOut();
              await stop();
            }
          } else {
            // программные ошибки клиента и сервера
            final errorText = '${code < 500 ? 'HTTP Client' : code < 600 ? 'HTTP Server' : 'Unknown HTTP'} Error $code';
            if (e.errCode == 'ERR_IMPORT_CONNECTION') {
              return handler.next(e);
            } else if (e.errCode.startsWith('ERR_IMPORT')) {
              _setImportError(e.detail, e.detail);
            } else {
              _setHTTPError(errorText, e.detail);
            }
          }
        }
      });

  /// UI
  static double get iconSize => P * 20;
  static const Color iconColor = darkBackgroundColor;

  Widget get _defaultIcon => appIcon();
  Widget get _authIcon => PrivacyIcon(size: iconSize, color: iconColor);
  Widget get _networkErrorIcon => NetworkErrorIcon(size: iconSize, color: iconColor);
  Widget get _serverErrorIcon => ServerErrorIcon(size: iconSize, color: iconColor);

  Widget _title(String titleText) => H3(
        titleText,
        align: TextAlign.center,
        padding: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P),
      );

  Widget _description(String descriptionText) => H4(
        descriptionText,
        align: TextAlign.center,
        padding: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P_2),
        maxLines: 5,
      );

  Widget _stopAction(String actionText) => MTButton.outlined(
        titleText: actionText,
        margin: const EdgeInsets.symmetric(horizontal: P),
        onTap: stop,
      );

  Widget _reportErrorButton(String errorText) => MTButton.outlined(
        titleColor: darkGreyColor,
        leading: const MailIcon(),
        titleText: loc.report_bug_action_title,
        margin: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P),
        onTap: () => launchUrlString('$contactUsMailSample%0D%0A$errorText'),
      );

  void _setHTTPError(String? errorText, String? errorDetail) {
    errorText ??= 'LoaderHTTPError';
    final mainRecommendationText = isWeb ? loc.update_web_app_recommendation_title : loc.update_app_recommendation_title;
    _set(
      icon: _serverErrorIcon,
      titleText: errorText,
      descriptionText: mainRecommendationText,
      action: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _stopAction(loc.ok),
          _reportErrorButton('$errorText ${errorDetail ?? ''}'),
        ],
      ),
    );
  }

  Future _reload() async {
    await stop();
    await mainController.update();
  }

  void _setNetworkError(String? errorText) => _set(
        icon: _networkErrorIcon,
        titleText: loc.network_error_title,
        descriptionText: loc.network_error_description,
        action: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MTButton.outlined(
              leading: const RefreshIcon(),
              titleText: loc.reload_action_title,
              margin: const EdgeInsets.symmetric(horizontal: P),
              onTap: _reload,
            ),
            _reportErrorButton(errorText ?? 'LoaderNetworkError'),
          ],
        ),
      );

  void setAuth() => _set(titleText: loc.loader_auth_title, icon: _authIcon);
  void setAuthError([String? description]) => _set(
        icon: _authIcon,
        titleText: loc.auth_error_title,
        descriptionText: description != null ? Intl.message('auth_error_$description') : loc.auth_error_description,
        actionText: loc.ok,
      );

  void setCheckConnection(String descriptionText) => _set(
        icon: ConnectingIcon(size: iconSize, color: iconColor),
        titleText: loc.loader_check_connection_title,
        descriptionText: descriptionText,
      );
  void setClosing(bool isClose) => _set(titleText: loc.loader_saving_title, icon: DoneIcon(isClose, size: iconSize, color: iconColor));
  void setDeleting() => _set(titleText: loc.loader_deleting_title, icon: DeleteIcon(size: iconSize, color: iconColor));
  void setImporting(String descriptionText) => _set(
        titleText: loc.loader_importing_title,
        descriptionText: descriptionText,
        icon: ImportIcon(size: iconSize, color: iconColor),
      );
  void _setImportError(String? descriptionText, String? errorDetail) => _set(
        titleText: loc.import_error_title,
        descriptionText: descriptionText,
        icon: ImportIcon(size: iconSize, color: iconColor),
        action: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _stopAction(loc.ok),
          _reportErrorButton('$descriptionText ${errorDetail ?? ''}'),
        ]),
      );
  void setRefreshing() => _set(titleText: loc.loader_refreshing_title, icon: RefreshIcon(size: iconSize, color: iconColor));
  void setSaving() => _set(titleText: loc.loader_saving_title, icon: EditIcon(size: iconSize, color: iconColor));
  void setSourceListing(String descriptionText) => _set(
        titleText: loc.loader_source_listing,
        descriptionText: descriptionText,
        icon: ImportIcon(size: iconSize, color: iconColor),
      );
  void setUnlinking() => _set(titleText: loc.loader_unlinking_title, icon: UnlinkIcon(size: iconSize, color: iconColor));
  void setUnwatch() => _set(titleText: loc.loader_unwatch_title, icon: EyeIcon(open: false, size: iconSize, color: iconColor));
}
