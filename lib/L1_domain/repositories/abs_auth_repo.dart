// Copyright (c) 2022. Alexandr Moroz

import '../entities/registration.dart';

abstract class AbstractAuthRepo {
  Future signOut();
  Future refreshToken();
  Future<bool> signInIsAvailable();
}

abstract class AbstractOAuthRepo extends AbstractAuthRepo {
  Future<String> signIn();
}

abstract class AbstractAuthAvanplanRepo extends AbstractAuthRepo {
  Future<bool> postRegistrationRequest(RegistrationRequest rRequest, String password);
  Future<String> signInWithPassword({String? email, String? pwd});
  Future<String> signInWithRegistration(String token);
}
