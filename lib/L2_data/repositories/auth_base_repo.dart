// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart';
import 'package:dio/dio.dart';

import '../services/api.dart';

mixin AuthMixin {
  AuthApi get authApi => avanplanApi.getAuthApi();

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
