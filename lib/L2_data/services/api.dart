// Copyright (c) 2024. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/app_local_settings.dart';
import 'environment.dart';
import 'platform.dart';

Openapi get openAPI => GetIt.I<Openapi>();

Map<String, dynamic> _headers(AppLocalSettings settings) {
  return <String, dynamic>{
    'avanplan-client-platform': platformCode,
    'avanplan-client-version': settings.version,
    'avanplan-client-locale': languageCode,
  };
}

Future<Openapi> setupApi(Iterable<Interceptor>? interceptors, AppLocalSettings settings) async {
  return Openapi(basePathOverride: apiUri.toString())
    ..dio.options.connectTimeout = const Duration(minutes: 1)
    ..dio.options.receiveTimeout = const Duration(minutes: 10)
    ..dio.options.headers.addAll(_headers(settings))
    ..dio.interceptors.addAll(interceptors ?? [])
    ..setApiKey('APIKeyHeader', apiKey);
}

extension DioErrorExt on DioException {
  String get errCode => response?.headers['err_code']?.first ?? '';
  String get detail {
    final dynamic resp = response?.data;
    return resp is Map ? resp['detail'].toString() : resp.toString();
  }
}
