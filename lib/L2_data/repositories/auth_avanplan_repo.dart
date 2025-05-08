// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as o_api;

import '../../L1_domain/entities/registration.dart';
import '../../L1_domain/repositories/abs_auth_repo.dart';
import 'auth_base_repo.dart';

class AuthAvanplanRepo extends AbstractAuthAvanplanRepo with AuthMixin {
  AuthAvanplanRepo(super.lsRepo);

  @override
  Future<String> signInWithPassword({String? email, String? pwd}) async {
    final response = await authApi.passwordToken(
      username: email ?? '',
      password: pwd ?? '',
    );
    return parseTokenResponse(response) ?? '';
  }

  @override
  Future signOut({bool disconnect = false}) async {}

  @override
  Future<bool> signInIsAvailable() async => true;

  @override
  Future<bool> postRegistrationRequest(RegistrationRequest rRequest, String password) async {
    final bodyData = (o_api.BodyRequestRegistrationBuilder()
          ..registration = (o_api.RegistrationBuilder()
            ..name = rRequest.name
            ..email = rRequest.email
            ..invitationToken = rRequest.invitationToken)
          ..password = password)
        .build();

    final response = await authApi.requestRegistration(bodyRequestRegistration: bodyData);
    return response.data == true;
  }

  @override
  Future<String> signInWithRegistration(String token) async {
    final bodyData = (o_api.BodyRegistrationTokenBuilder()..token = token).build();
    final response = await authApi.registrationToken(bodyRegistrationToken: bodyData);
    return parseTokenResponse(response) ?? '';
  }
}
