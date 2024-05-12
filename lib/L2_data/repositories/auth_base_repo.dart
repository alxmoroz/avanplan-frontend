// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';

import '../services/api.dart';

mixin AuthMixin {
  AuthApi get authApi => openAPI.getAuthApi();

  String? parseTokenResponse(Response<AuthToken> tokenResponse) => tokenResponse.data?.accessToken;

  Future<String> refreshToken() async {
    try {
      final tokenResponse = await authApi.refreshToken();
      return parseTokenResponse(tokenResponse) ?? '';
    } catch (_) {
      return '';
    }
  }
}
