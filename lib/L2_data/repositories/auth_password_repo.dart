// Copyright (c) 2022. Alexandr Moroz

import 'auth_base_repo.dart';

class AuthPasswordRepo extends AuthBaseRepo {
  @override
  Future<String> signIn({String? locale, String? email, String? pwd, bool? invited}) async {
    final response = await authApi.authToken(
      username: email ?? '',
      password: pwd ?? '',
    );
    return parseTokenResponse(response) ?? '';
  }

  @override
  Future<bool> signInIsAvailable() async => true;

  @override
  Future signOut() async {}
}
