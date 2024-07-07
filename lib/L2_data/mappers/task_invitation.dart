// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/invitation.dart';

extension TaskInvitationMapper on api.InvitationGet {
  Invitation get invitation => Invitation(
        taskId,
        roleId,
        expiresOn.toLocal(),
        url: url,
      );
}
