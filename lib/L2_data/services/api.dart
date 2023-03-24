// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:openapi/openapi.dart';

Openapi get openAPI => GetIt.I<Openapi>();

const API_PATH = 'https://avanplan.ru/api/';
// const API_PATH = 'http://localhost:8000/';
// const API_PATH = 'http://10.0.2.2:8000';

Openapi setupApi(Iterable<Interceptor>? interceptors) {
  return Openapi(basePathOverride: API_PATH)
    ..dio.options.connectTimeout = 600000
    ..dio.options.receiveTimeout = 600000
    ..dio.interceptors.addAll(interceptors ?? []);
}

extension DioErrorExt on DioError {
  String get errCode => response?.headers['err_code']?.first ?? '';
  String get detail {
    final dynamic resp = response?.data;

    return resp is Map ? resp['detail'].toString() : resp.toString();
  }
}
