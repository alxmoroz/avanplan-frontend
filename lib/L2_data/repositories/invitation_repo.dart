// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/invitation.dart';
import '../../L1_domain/repositories/abs_invitation_repo.dart';
import '../services/api.dart';

class InvitationRepo extends AbstractInvitationRepo {
  o_api.InvitationApi get api => openAPI.getInvitationApi();

  @override
  Future<String> create(Invitation invitation, int wsId) async {
    final invitationData = (o_api.InvitationBuilder()
          ..roleId = invitation.roleId
          ..taskId = invitation.taskId
          ..activationsCount = invitation.activationsCount
          ..activeUntil = invitation.activeUntil.toUtc())
        .build();
    final response = await api.createV1InvitationCreatePost(wsId: wsId, invitation: invitationData);
    return response.data ?? '';
  }

  @override
  Future<bool> redeem(String token) async {
    final body = (o_api.BodyRedeemV1InvitationRedeemPostBuilder()..token = token).build();
    final response = await api.redeemV1InvitationRedeemPost(bodyRedeemV1InvitationRedeemPost: body);
    return response.data == true;
  }
}
