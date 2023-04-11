// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';

import '../services/api.dart';

abstract class AuthBaseRepo {
  AuthApi get authApi => openAPI.getAuthApi();

  String? parseTokenResponse(Response<Token> tokenResponse) => tokenResponse.data?.accessToken;

  Future<String> refreshToken() async => parseTokenResponse(await authApi.refreshToken()) ?? '';
}
