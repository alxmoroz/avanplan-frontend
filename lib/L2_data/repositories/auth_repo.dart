// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/repositories/abs_auth_repo.dart';
import '../../L3_app/extra/services.dart';

class AuthRepo extends AbstractAuthRepo {
  @override
  Future<String> getApiAuthToken(String username, String password) async {
    String accessToken = '';

    final response = await openAPI.getAuthApi().getAuthToken(
          username: username,
          password: password,
        );

    if (response.statusCode == 200) {
      final token = response.data;
      if (token != null) {
        accessToken = token.accessToken;
      }
    }
    // TODO: обработка ошибок авторизации...
    return accessToken;
  }

  @override
  void setApiCredentials(String token) {
    openAPI.setOAuthToken('OAuth2PasswordBearer', token);
  }
}
