// Copyright (c) 2022. Alexandr Moroz

import '../entities/invitation.dart';

abstract class AbstractProjectInvitationsRepo {
  Future<Invitation?> create(Invitation invitation, int wsId) async => throw UnimplementedError();
  Future<Invitation?> getInvitation(int wsId, int taskId, int roleId) async => throw UnimplementedError();
}
