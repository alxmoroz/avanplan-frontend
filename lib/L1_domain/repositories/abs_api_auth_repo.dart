// Copyright (c) 2022. Alexandr Moroz

abstract class AbstractAuthRepo {
  Future<bool> signInIsAvailable();
  Future<String> signIn({String? login, String? pwd, String? locale});
  Future signOut();
  Future refreshToken();
}
