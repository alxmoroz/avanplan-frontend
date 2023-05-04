// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:openapi/openapi.dart';

import 'environment.dart';

Openapi get openAPI => GetIt.I<Openapi>();

Future<Openapi> setupApi(Iterable<Interceptor>? interceptors) async {
  return Openapi(basePathOverride: apiPath)
    ..dio.options.connectTimeout = const Duration(minutes: 1)
    ..dio.options.receiveTimeout = const Duration(minutes: 10)
    ..dio.interceptors.addAll(interceptors ?? [])
    ..setApiKey('APIKeyHeader', apiKey);
}

extension DioErrorExt on DioError {
  String get errCode => response?.headers['err_code']?.first ?? '';
  String get detail {
    final dynamic resp = response?.data;

    return resp is Map ? resp['detail'].toString() : resp.toString();
  }
}
