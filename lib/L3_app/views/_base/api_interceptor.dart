// Copyright (c) 2024. Alexandr Moroz

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

final apiInterceptor = InterceptorsWrapper(onError: (e, handler) async {
  // обрабатываем тут только SocketException, остальные должны быть перехвачены в контроллерах маршрута
  if (e.error is SocketException) {
    // TODO: что тут делать? Показывать диалог поверх всего?

    // set(
    //   titleText: 'SocketException',
    //   descriptionText: '$e',
    //   action: Container(),
    // );

    // void _setNetworkError(String? errorText) => set(
    //   imageName: ImageName.network_error.name,
    //   titleText: loc.error_network_title,
    //   descriptionText: loc.error_network_description,
    //   action: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       _stopAction(loc.ok),
    //       ReportErrorButton(errorText ?? 'LoaderNetworkError'),
    //     ],
    //   ),
    // );

    // _setNetworkError('${e.error}');

    if (kDebugMode) {
      print('SocketException $e');
    }
  } else {
    return handler.next(e);
  }
});
