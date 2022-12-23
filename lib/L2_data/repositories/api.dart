// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:openapi/openapi.dart';

Openapi get openAPI => GetIt.I<Openapi>();

Openapi setupApi(Iterable<Interceptor>? interceptors) {
  return Openapi(basePathOverride: 'https://avanplan.ru/api/')
    // return Openapi(basePathOverride: 'http://localhost:8000/')
    ..dio.options.connectTimeout = 300000
    ..dio.options.receiveTimeout = 300000
    ..dio.interceptors.addAll(interceptors ?? []);
}

extension DioErrorExt on DioError {
  String get errCode => response?.headers['err_code']?.first ?? '';
  String get detail => response?.data is String ? response?.data : response?.data['detail'] ?? '';
}
