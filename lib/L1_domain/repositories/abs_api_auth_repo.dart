// Copyright (c) 2022. Alexandr Moroz

abstract class AbstractAuthRepo {
  Future<bool> signInIsAvailable();
  Future<String> signIn({String? username, String? password, String? locale});
  Future signOut();
}
