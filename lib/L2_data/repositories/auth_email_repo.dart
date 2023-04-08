// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import 'auth_base_repo.dart';

class AuthEmailRepo extends AuthBaseRepo {
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

  @override
  Future<bool> register({required String name, required String email, required String pwd, required String locale}) async {
    final response = await authApi.register(
      bodyRegister: (BodyRegisterBuilder()
            ..name = name
            ..email = email
            ..password = pwd
            ..locale = locale)
          .build(),
    );
    return response.data == true;
  }
}
