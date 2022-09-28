// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';

import '../../L1_domain/repositories/abs_auth_repo.dart';
import '../../L1_domain/system/errors.dart';
import '../../L3_app/extra/services.dart';

class AuthRepo extends AbstractAuthRepo {
  @override
  Future<String> getApiAuthToken(String username, String password) async {
    String accessToken = '';

    try {
      final response = await openAPI.getAuthApi().getAuthToken(
            username: username,
            password: password,
          );

      if (response.statusCode == 200) {
        final token = response.data;
        if (token != null) {
          accessToken = token.accessToken;
        }
      } else {
        throw MTException(code: '${response.statusCode}', detail: response.statusMessage);
      }
    } catch (e) {
      throw MTException(code: e is DioError ? '${e.response?.statusCode}' : '', detail: e.toString());
    }

    return accessToken;
  }

  @override
  void setApiCredentials(String token) {
    openAPI.setOAuthToken('OAuth2PasswordBearer', token);
  }
}
