// Copyright (c) 2022. Alexandr Moroz

abstract class AbstractAuthRepo {
  Future<String> getApiAuthToken(String username, String password);
  Future<String> getApiAuthGoogleToken();
  Future<bool> authWithAppleIsAvailable();
  Future<String> getApiAuthAppleToken();
  Future logout();
  void setApiCredentials(String token);
}
