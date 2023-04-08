// Copyright (c) 2022. Alexandr Moroz

abstract class AbstractAuthRepo {
  Future<bool> signInIsAvailable();
  Future<String> signIn({String? email, String? pwd, String? locale, bool? invited});
  Future signOut();
  Future refreshToken();
  Future register({required String name, required String email, required String pwd, required String locale});
}
