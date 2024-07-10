// Copyright (c) 2024. Alexandr Moroz

import '../entities/registration.dart';

abstract class AbstractAuthRepo {
  Future signOut() async => throw UnimplementedError();
  Future<bool> signInIsAvailable() async => throw UnimplementedError();
  Future<String> refreshToken() async => throw UnimplementedError();
}

abstract class AbstractOAuthRepo extends AbstractAuthRepo {
  Uri get serverAuthCodeUri => throw UnimplementedError();
  Future<String> signIn({String? serverAuthCode}) async => throw UnimplementedError();
}

abstract class AbstractAuthAvanplanRepo extends AbstractAuthRepo {
  Future<bool> postRegistrationRequest(RegistrationRequest rRequest, String password) async => throw UnimplementedError();
  Future<String> signInWithPassword({String? email, String? pwd}) async => throw UnimplementedError();
  Future<String> signInWithRegistration(String token) async => throw UnimplementedError();
}
