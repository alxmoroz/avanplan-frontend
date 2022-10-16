// Copyright (c) 2022. Alexandr Moroz

abstract class AbstractAuthRepo {
  Future<String> getApiAuthToken(String username, String password);
  Future<String> getApiAuthTokenGoogleOauth();
  void setApiCredentials(String token);
}
