// Copyright (c) 2022. Alexandr Moroz

import 'auth_base_repo.dart';

class AuthPasswordRepo extends AuthBaseRepo {
  @override
  Future<String> signIn({String? locale, String? login, String? pwd, bool? invited}) async {
    final response = await authApi.authToken(
      username: login ?? '',
      password: pwd ?? '',
    );
    return parseTokenResponse(response) ?? '';
  }

  @override
  Future<bool> signInIsAvailable() async => true;

  @override
  Future signOut() async {}
}
