// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';

import '../../L1_domain/repositories/abs_auth_repo.dart';
import '../services/api.dart';

abstract class AuthBaseRepo extends AbstractAuthRepo {
  AuthBaseRepo() : authApi = openAPI.getAuthApi();
  final AuthApi authApi;

  String? parseTokenResponse(Response<Token> tokenResponse) => tokenResponse.data?.accessToken;

  @override
  Future<String> refreshToken() async => parseTokenResponse(await authApi.refreshToken()) ?? '';
}
