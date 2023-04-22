// Copyright (c) 2022. Alexandr Moroz

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart' hide Interceptor;

import '../../../L2_data/repositories/communications_repo.dart';
import '../../../L2_data/services/api.dart';
import '../../../L2_data/services/platform.dart';
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
        if (e.type == DioErrorType.badResponse) {
          final code = e.response?.statusCode ?? 666;
          final path = e.requestOptions.path;

          if ([401, 403, 407].contains(code)) {
            // ошибки авторизации
            if (path.startsWith('/v1/auth')) {
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
              await stop();
            }
          } else {
            // программные ошибки сервера
            final errorText = '${code < 500 ? 'HTTP Client' : code < 600 ? 'HTTP Server' : 'Unknown HTTP'} Error $code';
            if (e.errCode == 'ERR_IMPORT_CONNECTION') {
              return handler.next(e);
            } else if (e.errCode.startsWith('ERR_IMPORT')) {
              _setImportError(e.detail, e.detail);
            } else {
              _setHTTPError(errorText, e.detail);
            }
          }
        } else {
          if (e.error is SocketException) {
            _setNetworkError('${e.error}');
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
        onTap: stop,
      );

  // TODO: нужен репозиторий для отправки писем, см. как формируется форма для оплаты
  Widget _reportErrorButton(String errorText) => MTButton.outlined(
        titleColor: darkGreyColor,
        leading: const MailIcon(),
        titleText: loc.report_bug_action_title,
        margin: const EdgeInsets.only(top: P),
        onTap: () => sendMail(loc.contact_us_mail_subject, appTitle, accountController.user?.id, errorText),
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
    await mainController.manualUpdate();
  }

  void _setNetworkError(String? errorText) => _set(
        icon: _networkErrorIcon,
        titleText: loc.error_network_title,
        descriptionText: loc.error_network_description,
        action: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _stopAction(loc.ok),
            MTButton.outlined(
              leading: const RefreshIcon(),
              titleText: loc.reload_action_title,
              margin: const EdgeInsets.only(top: P),
              onTap: _reload,
            ),
            _reportErrorButton(errorText ?? 'LoaderNetworkError'),
          ],
        ),
      );

  void setAuth() => _set(titleText: loc.loader_auth_title, icon: _authIcon);
  void setAuthError([String? description]) => _set(
        icon: _authIcon,
        titleText: loc.error_auth_title,
        descriptionText: description != null ? Intl.message('error_auth_$description') : loc.error_auth_description,
        actionText: loc.ok,
      );

  void _setPermissionError([String? description]) => _set(
        icon: _authIcon,
        titleText: loc.error_permission_title,
        descriptionText: description != null ? Intl.message('error_permission_$description') : loc.error_permission_description,
        actionText: loc.ok,
      );

  void _setTariffLimitError([String? description]) => _set(
        icon: _authIcon,
        titleText: loc.error_tariff_limit_title,
        descriptionText: description != null ? Intl.message('error_tariff_limit_$description') : loc.error_tariff_limit_description,
        actionText: loc.ok,
      );

  void setRedeemInvitation() => _set(titleText: loc.loader_invitation_redeem_title, icon: _authIcon);
  void setCreateInvitation() => _set(titleText: loc.loader_invitation_create_title, icon: _authIcon);
  void _setRedeemInvitationError() => _set(
        icon: _authIcon,
        titleText: loc.error_redeem_invitation_title,
        descriptionText: loc.error_redeem_invitation_description,
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
        titleText: loc.error_import_menu_action_title,
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
