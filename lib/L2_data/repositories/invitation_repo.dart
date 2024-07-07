// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/invitation.dart';
import '../../L1_domain/repositories/abs_invitation_repo.dart';
import '../mappers/task_invitation.dart';
import '../services/api.dart';

class InvitationRepo extends AbstractInvitationRepo {
  o_api.TaskInvitationsApi get api => openAPI.getTaskInvitationsApi();

  @override
  Future<Invitation?> create(Invitation invitation, int wsId) async {
    final data = (o_api.InvitationBuilder()
          ..roleId = invitation.roleId
          ..taskId = invitation.taskId
          ..expiresOn = invitation.expiresOn.toUtc())
        .build();
    final response = await api.createInvitation(
      wsId: wsId,
      taskId: invitation.taskId,
      invitation: data,
    );
    return response.data?.invitation;
  }

  @override
  Future<Invitation?> getInvitation(int wsId, int taskId, int roleId) async {
    final response = await api.getInvitations(
      wsId: wsId,
      roleId: roleId,
      taskId: taskId,
    );
    return response.data?.map((inv) => inv.invitation).firstOrNull;
  }
}
