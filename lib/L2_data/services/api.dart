// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:openapi/openapi.dart';

Openapi get openAPI => GetIt.I<Openapi>();

Future<Openapi> setupApi(Iterable<Interceptor>? interceptors) async {
  final apiPath = dotenv.get('API_PATH', fallback: 'https://avanplan.ru/api/');
  return Openapi(basePathOverride: apiPath)
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
