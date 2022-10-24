// Copyright (c) 2022. Alexandr Moroz

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:openapi/openapi.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../L3_app/components/colors.dart';
import '../../L3_app/components/constants.dart';
import '../../L3_app/components/icons.dart';
import '../../L3_app/components/mt_button.dart';
import '../../L3_app/extra/services.dart';
import '../../L3_app/presenters/communications_presenter.dart';
import 'platform.dart';

Openapi get openAPI => GetIt.I<Openapi>();

void _reportError(String error) {
  launchUrlString('$contactUsMailSample%0D%0A$error');
}

void _setLoader(String errorText) {
  final mainRecommendationText = isWeb ? loc.update_web_app_recommendation_title : loc.update_app_recommendation_title;
  loaderController.setLoader(
    null,
    icon: NetworkErrorIcon(size: onePadding * 10),
    titleText: errorText,
    descriptionText: '$mainRecommendationText\n${loc.report_bug_action_title}',
    action: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MTButton.outlined(
          titleText: loc.ok,
          margin: EdgeInsets.symmetric(horizontal: onePadding),
          onTap: () => loaderController.hideLoader(),
        ),
        MTButton.outlined(
          titleColor: darkColor,
          leading: const MailIcon(),
          titleText: loc.contact_us_title,
          margin: EdgeInsets.symmetric(horizontal: onePadding).copyWith(top: onePadding),
          onTap: () => _reportError(errorText),
        ),
      ],
    ),
  );
}

Widget _actionNetworkError(String errorText) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      MTButton.outlined(
        leading: const RefreshIcon(),
        titleText: loc.reload_action_title,
        margin: EdgeInsets.symmetric(horizontal: onePadding),
        onTap: () => mainController.updateAll(null),
      ),
      MTButton.outlined(
        titleColor: darkColor,
        leading: const MailIcon(),
        titleText: loc.report_bug_action_title,
        margin: EdgeInsets.symmetric(horizontal: onePadding).copyWith(top: onePadding),
        onTap: () => _reportError(errorText),
      ),
    ],
  );
}

Openapi setupApi() {
  final api = Openapi(basePathOverride: 'https://gercul.es/api/');
  // final api = Openapi(basePathOverride: 'http://localhost:8000/');
  api.dio.options.connectTimeout = 300000;
  api.dio.options.receiveTimeout = 300000;

  // TODO: Он должен отправлять MTException в контроллеры для обработки их там уже и лоадером там же управлять, а не тут
  api.dio.interceptors.add(InterceptorsWrapper(onError: (DioError e, handler) async {
    if (e.type == DioErrorType.other) {
      if (e.error is SocketException) {
        loaderController.setLoader(
          null,
          icon: NetworkErrorIcon(size: onePadding * 10),
          titleText: loc.network_error_title,
          descriptionText: loc.network_error_description,
          action: _actionNetworkError('${e.error}'),
        );
        print(e.error);
      }
    } else if (e.type == DioErrorType.response) {
      final code = e.response?.statusCode ?? 666;
      final path = e.requestOptions.path;

      if ([401, 403, 407].contains(code)) {
        // ошибки авторизации
        if (!path.startsWith('/v1/auth')) {
          // Обрабатываются дальше, если это именно авторизация.
          //... остальных случаях выбрасываем без объяснений
          await authController.logout();
        }
      } else {
        // программные ошибки клиента и сервера
        final errorText = '${code < 500 ? 'HTTP Client' : code < 600 ? 'HTTP Server' : 'Unknown HTTP'} Error $code';
        // TODO: сейчас 500 выдаётся на случай проблем соединения с источником импорта. Это нужно обрабатывать отдельно #2055
        // TODO: либо код должен быть 2xx, либо тут исключение делать по path

        // TODO: не правильно обрабатывается логика каскада запросов, среди которых могут быть ок и не ок
        _setLoader(errorText);
      }
      return handler.next(e);
    }
  }));
  return api;
}
