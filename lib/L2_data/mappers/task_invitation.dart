// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as api;

import '../../L1_domain/entities/invitation.dart';

extension TaskInvitationMapper on api.InvitationGet {
  Invitation get invitation => Invitation(
        taskId,
        roleId,
        expiresOn.toLocal(),
        url: url,
      );
}
