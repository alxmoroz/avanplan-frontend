// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/repositories/abs_auth_repo.dart';
import 'auth_base_repo.dart';

class AuthEmailRepo extends AbstractAuthAvanplanRepo with AuthBaseRepo {
  @override
  Future<String> signIn({String? email, String? pwd}) async {
    final response = await authApi.authToken(
      username: email ?? '',
      password: pwd ?? '',
    );
    return parseTokenResponse(response) ?? '';
  }

  @override
  Future signOut() async {}

  @override
  Future<bool> signInIsAvailable() async => true;
}
