// Copyright (c) 2022. Alexandr Moroz

import '../entities/invitation.dart';
import '../repositories/abs_invitation_repo.dart';

class InvitationUC {
  InvitationUC(this.repo);
  Future<InvitationUC> init() async => this;

  final AbstractInvitationRepo repo;

  Future<String> create(Invitation invitation, int wsId) async => await repo.create(invitation, wsId);
}
