// Copyright (c) 2022. Alexandr Moroz

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart' hide Interceptor;
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L2_data/repositories/platform.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/text_widgets.dart';
import '../../presenters/communications_presenter.dart';
import '../services.dart';
import 'loader_screen.dart';

part 'loader_controller.g.dart';

class LoaderController extends _LoaderControllerBase with _$LoaderController {}

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
  BuildContext? _loaderContext;

  // @observable
  // ObservableList<VoidCallback>? callbacks;

  @observable
  int stack = 0;

  @action
  void setLoader(
    BuildContext? context, {
    String? titleText,
    Widget? title,
    String? descriptionText,
    Widget? description,
    Widget? icon,
    String? actionText,
    Widget? action,
  }) {
    iconWidget = icon ?? gerculesIcon();
    titleWidget = title ??
        (titleText != null
            ? H3(
                titleText,
                align: TextAlign.center,
                padding: EdgeInsets.symmetric(horizontal: onePadding).copyWith(top: onePadding),
              )
            : null);
    descriptionWidget = description ??
        (descriptionText != null
            ? H4(
                descriptionText,
                align: TextAlign.center,
                padding: EdgeInsets.symmetric(horizontal: onePadding).copyWith(top: onePadding / 2),
                maxLines: 5,
              )
            : null);

    actionWidget = action ??
        (actionText != null
            ? MTButton.outlined(
                titleText: actionText,
                margin: EdgeInsets.symmetric(horizontal: onePadding),
                onTap: hideLoader,
              )
            : null);

    if (_loaderContext == null && context != null && stack == 0) {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          useSafeArea: false,
          builder: (BuildContext context) {
            _loaderContext = context;
            return LoaderScreen();
          });
      stack++;
    }
  }

  @action
  void hideLoader() {
    if (_loaderContext != null && --stack == 0) {
      Navigator.of(_loaderContext!).pop();
      _loaderContext = null;
    }
  }

  Iterable<Interceptor> get dioInterceptors {
    return [
      InterceptorsWrapper(onError: (e, handler) async {
        if (e.type == DioErrorType.other) {
          if (e.error is SocketException) {
            _setNetworkError('${e.error}');
          }
        } else if (e.type == DioErrorType.response) {
          final code = e.response?.statusCode ?? 666;
          final path = e.requestOptions.path;
          final errCode = e.response?.headers['err_code']?.first;

          print('InterceptorsWrapper $errCode');

          if ([401, 403, 407].contains(code)) {
            // ошибки авторизации
            if (!path.startsWith('/v1/auth')) {
              // Обрабатываются дальше, если это именно авторизация.
              //... остальных случаях выбрасываем без объяснений
              await authController.logout();
            } else {
              _setAuthError();
            }
          } else {
            // программные ошибки клиента и сервера
            final errorText = '${code < 500 ? 'HTTP Client' : code < 600 ? 'HTTP Server' : 'Unknown HTTP'} Error $code';
            _setHTTPError(errorText);
          }
        }
        return handler.next(e);
      })
    ];
  }

  Widget _reportErrorButton(String errorText) => MTButton.outlined(
        titleColor: darkColor,
        leading: const MailIcon(),
        titleText: loc.report_bug_action_title,
        margin: EdgeInsets.symmetric(horizontal: onePadding).copyWith(top: onePadding),
        onTap: () => launchUrlString('$contactUsMailSample%0D%0A$errorText'),
      );

  Widget get authIcon => PrivacyIcon(size: onePadding * 10, color: lightGreyColor);

  void _setAuthError() {
    setLoader(
      null,
      icon: authIcon,
      titleText: loc.auth_error_title,
      descriptionText: loc.auth_error_description,
      actionText: loc.ok,
    );
  }

  void _setHTTPError(String? errorText) {
    errorText ??= 'LoaderHTTPError';
    final mainRecommendationText = isWeb ? loc.update_web_app_recommendation_title : loc.update_app_recommendation_title;
    setLoader(
      null,
      icon: NetworkErrorIcon(size: onePadding * 10),
      titleText: errorText,
      descriptionText: mainRecommendationText,
      action: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MTButton.outlined(
            titleText: loc.ok,
            margin: EdgeInsets.symmetric(horizontal: onePadding),
            onTap: () => loaderController.hideLoader(),
          ),
          _reportErrorButton(errorText),
        ],
      ),
    );
  }

  void _setNetworkError(String? errorText) {
    errorText ??= 'LoaderNetworkError';
    setLoader(
      null,
      icon: NetworkErrorIcon(size: onePadding * 10),
      titleText: loc.network_error_title,
      descriptionText: loc.network_error_description,
      action: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MTButton.outlined(
            leading: const RefreshIcon(),
            titleText: loc.reload_action_title,
            margin: EdgeInsets.symmetric(horizontal: onePadding),
            onTap: () => mainController.updateAll(null),
          ),
          _reportErrorButton(errorText),
        ],
      ),
    );
  }
}
