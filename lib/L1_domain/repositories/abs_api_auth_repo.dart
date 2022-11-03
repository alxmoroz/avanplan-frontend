// Copyright (c) 2022. Alexandr Moroz

abstract class AbstractAuthRepo {
  Future<String> getApiAuthToken(String username, String password);
  Future<String> getApiAuthGoogleToken();
  Future<bool> signInWithAppleIsAvailable();
  Future<String> getApiAuthAppleToken();
  Future signOut();
  void setApiCredentials(String token);
}
