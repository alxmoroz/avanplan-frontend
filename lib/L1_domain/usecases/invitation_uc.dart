// Copyright (c) 2022. Alexandr Moroz

import '../entities/invitation.dart';
import '../repositories/abs_project_invitations_repo.dart';

class InvitationUC {
  InvitationUC(this.repo);

  final AbstractProjectInvitationsRepo repo;

  Future<Invitation?> create(Invitation invitation, int wsId) async => await repo.create(invitation, wsId);
  Future<Invitation?> getInvitation(int wsId, int taskId, int roleId) async => await repo.getInvitation(wsId, taskId, roleId);
}
