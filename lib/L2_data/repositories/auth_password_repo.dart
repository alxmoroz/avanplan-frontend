// Copyright (c) 2022. Alexandr Moroz

import 'auth_base_repo.dart';

class AuthPasswordRepo extends AuthBaseRepo {
  @override
  Future<String> signIn({String? username, String? password}) async {
    final response = await authApi.authToken(
      username: username ?? '',
      password: password ?? '',
    );
    return parseTokenResponse(response) ?? '';
  }

  @override
  Future<bool> signInIsAvailable() async => true;

  @override
  Future signOut() async {}
}
