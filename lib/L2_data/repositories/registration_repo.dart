// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/registration.dart';
import '../../L1_domain/repositories/abs_registration_repo.dart';
import '../services/api.dart';
import 'auth_base_repo.dart';

class RegistrationRepo extends AbstractRegistrationRepo with AuthBaseRepo {
  o_api.RegistrationApi get api => openAPI.getRegistrationApi();

  @override
  Future<bool> create(Registration registration, String password) async {
    final bodyData = (o_api.BodyCreateV1RegistrationCreatePostBuilder()
          ..registration = (o_api.RegistrationBuilder()
            ..name = registration.name
            ..email = registration.email
            ..locale = registration.locale)
          ..password = password)
        .build();

    final response = await api.createV1RegistrationCreatePost(bodyCreateV1RegistrationCreatePost: bodyData);
    return response.data == true;
  }

  @override
  Future<String> redeem(String token) async {
    final bodyData = (o_api.BodyRedeemV1RegistrationRedeemPostBuilder()..token = token).build();
    final response = await api.redeemV1RegistrationRedeemPost(bodyRedeemV1RegistrationRedeemPost: bodyData);
    return parseTokenResponse(response) ?? '';
  }
}
