// Copyright (c) 2022. Alexandr Moroz

abstract class AbstractAuthRepo {
  Future<String> signIn();
  Future signOut();
  Future refreshToken();
  Future<bool> signInIsAvailable();
}

abstract class AbstractOAuthRepo extends AbstractAuthRepo {
  @override
  Future<String> signIn({String? locale});
}

abstract class AbstractAuthAvanplanRepo extends AbstractAuthRepo {
  @override
  Future<String> signIn({String? email, String? pwd});
}
