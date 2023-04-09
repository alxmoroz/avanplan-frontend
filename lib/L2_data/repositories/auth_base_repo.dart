// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';

import '../../L1_domain/repositories/abs_auth_repo.dart';
import '../services/api.dart';

String? parseTokenResponse(Response<Token> tokenResponse) => tokenResponse.data?.accessToken;

abstract class AuthBaseRepo extends AbstractAuthRepo {
  AuthBaseRepo() : authApi = openAPI.getAuthApi();
  final AuthApi authApi;

  @override
  Future<String> refreshToken() async => parseTokenResponse(await authApi.refreshToken()) ?? '';
}
