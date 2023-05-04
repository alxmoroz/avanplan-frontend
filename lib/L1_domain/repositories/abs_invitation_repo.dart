// Copyright (c) 2022. Alexandr Moroz

import '../entities/invitation.dart';

abstract class AbstractInvitationRepo {
  Future<Invitation?> create(Invitation invitation, int wsId);
  Future<Invitation?> getInvitation(int wsId, int taskId, int roleId);
}
