// Copyright (c) 2022. Alexandr Moroz

import '../entities/invitation.dart';

abstract class AbstractInvitationRepo {
  Future<String> create(Invitation invitation, int wsId);
}
