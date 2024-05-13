// Copyright (c) 2024. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/errors.dart';
import '../../../L2_data/services/api.dart';
import '../../../L2_data/services/platform.dart';
import '../../components/button.dart';
import '../../components/images.dart';
import '../../extra/services.dart';
import '../../presenters/communications.dart';

part 'loadable.g.dart';

mixin Loadable {
  final _l = LoadableState();
  LoadableState get loaderState => _l;
  bool get loading => _l.loading;

  void setLoaderScreen({
    String? titleText,
    String? descriptionText,
    String? imageName,
    String? actionText,
    Widget? action,
  }) =>
      _l.set(
        titleText: titleText,
        descriptionText: descriptionText,
        imageName: imageName,
        actionText: actionText,
        action: action,
      );

  void setLoaderScreenLoading() => _l.set(titleText: loc.loader_refreshing_title, imageName: ImageName.loading.name);
  void setLoaderScreenSaving() => _l.set(titleText: loc.loader_saving_title, imageName: ImageName.save.name);
  void setLoaderScreenDeleting() => _l.set(titleText: loc.loader_deleting_title, imageName: ImageName.delete.name);

  void startLoading() => _l.start();
  void stopLoading() => _l.stop();

  Future load(Function() function) async {
    startLoading();
    try {
      await function();
      stopLoading();
    } on Exception catch (e) {
      parseError(e);
    }
  }

  void parseError(Exception e) => _l.parseError(e);
}

class LoadableState extends _LoadableBase with _$LoadableState {
  void parseError(Exception e) {
    if (e is MTOAuthError) {
      _setAuthError();
    } else if (e is DioException && e.type == DioExceptionType.badResponse) {
      final code = e.response?.statusCode ?? 666;
      final path = e.requestOptions.path;

      if ([401, 403, 407].contains(code)) {
        // ошибки авторизации
        if (path.startsWith('/v1/auth/password_token')) {
          // Показываем диалог, если это именно авторизация
          _setAuthError();
        } else if (e.errCode.startsWith('ERR_PERMISSION_BALANCE')) {
          // Сюда логика не должна попадать. Но на всякий случай обрабатываем такую ошибку.
          // Это могут быть программные ошибки, хакеры, а также если пользователь долго не обновлял данные на клиенте
          // TODO: замечание актуально, пока нет активного фонового обновления
          // TODO: нужно показывать текст про баланс, либо вообще сразу диалог для пополнения
          // Показываем диалог ограничений тарифа
          _setTariffLimitError();
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
          authController.signOut();
        }
      } else {
        // программные ошибки сервера
        final errorText = '${code < 500 ? 'HTTP Client' : code < 600 ? 'HTTP Server' : 'Unknown HTTP'} Error $code';
        if (e.errCode.startsWith('ERR_IMPORT')) {
          _setImportError(e.detail, e.detail);
        } else {
          if (kDebugMode) {
            print(e);
          }
          _setHTTPError(errorText, e.detail);
        }
      }
    } else {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // TODO: для веба это должен быть диалог поверх маршрута тут в случае ошибки
  void _setAuthError([String? description]) => set(
        imageName: ImageName.privacy.name,
        titleText: loc.error_auth_title,
        descriptionText: description != null ? Intl.message('error_auth_$description') : loc.error_auth_description,
        actionText: loc.ok,
      );

  void _setHTTPError(String? errorText, String? errorDetail) {
    errorText ??= 'LoaderHTTPError';
    final mainRecommendationText = isWeb ? loc.error_http_upgrade_web_recommendation_title : loc.error_http_upgrade_app_recommendation_title;
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

  void _setPermissionError([String? description]) => set(
        imageName: ImageName.privacy.name,
        titleText: loc.error_permission_title,
        descriptionText: description != null ? Intl.message('error_permission_$description') : loc.error_permission_description,
        actionText: loc.ok,
      );

  void _setTariffLimitError([String? description]) => set(
        imageName: ImageName.purchase.name,
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

  void _setImportError(String? descriptionText, String? errorDetail) => set(
        titleText: loc.error_import_title,
        descriptionText: descriptionText,
        imageName: ImageName.import.name,
        action: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _stopAction(loc.ok),
          ReportErrorButton('$descriptionText ${errorDetail ?? ''}'),
        ]),
      );
}

abstract class _LoadableBase with Store {
  @observable
  bool loading = true;

  @action
  void start() => loading = true;

  @action
  void stop() => loading = false;

  @observable
  String? imageName;

  @observable
  String? titleText;

  @observable
  String? descriptionText;

  @observable
  Widget? actionWidget;

  Widget _stopAction(String actionText) => MTButton.main(
        titleText: actionText,
        onTap: stop,
      );

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
}
