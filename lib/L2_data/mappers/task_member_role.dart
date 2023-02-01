// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/task_member_role.dart';
import 'member.dart';
import 'task_role.dart';

extension TaskMemberRoleMapper on TaskMemberRoleGet {
  TaskMemberRole tmRole(int wsId) => TaskMemberRole(
        id: id,
        wsId: wsId,
        member: member.member(wsId),
        role: role.role,
      );
}
