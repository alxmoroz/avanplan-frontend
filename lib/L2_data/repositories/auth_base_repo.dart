// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';

import '../../L1_domain/repositories/abs_api_auth_repo.dart';
import '../services/api.dart';

abstract class AuthBaseRepo extends AbstractAuthRepo {
  AuthBaseRepo() : authApi = openAPI.getAuthApi();
  final AuthApi authApi;

  String? parseTokenResponse(Response<Token> tokenResponse) {
    if (tokenResponse.statusCode == 200) {
      final token = tokenResponse.data;
      if (token != null) {
        return token.accessToken;
      }
    }
    return null;
  }
}
