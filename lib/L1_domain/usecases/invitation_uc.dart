// Copyright (c) 2022. Alexandr Moroz

import '../entities/invitation.dart';
import '../repositories/abs_invitation_repo.dart';

class InvitationUC {
  InvitationUC(this.repo);
  Future<InvitationUC> init() async => this;

  final AbstractInvitationRepo repo;

  Future<Invitation?> create(Invitation invitation, int wsId) async => await repo.create(invitation, wsId);
  Future<Invitation?> getInvitation(int wsId, int taskId, int roleId) async => await repo.getInvitation(wsId, taskId, roleId);
}
