// Copyright (c) 2022. Alexandr Moroz

import '../entities/invitation.dart';
import '../repositories/abs_invitation_repo.dart';

class InvitationUC {
  InvitationUC({required this.repo});

  final AbstractInvitationRepo repo;

  Future<String> create(Invitation invitation, int wsId) async => await repo.create(invitation, wsId);
  Future<bool> redeem(String url) async => await repo.redeem(url);
}
