// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/task_member.dart';

extension MemberMapper on api.MemberGet {
  TaskMember member(int taskId) => TaskMember(
        id: id,
        email: email,
        fullName: fullName,
        roles: roleCodes ?? [],
        permissions: permissionCodes ?? [],
        isActive: isActive == true,
        userId: userId,
        taskId: taskId,
      );
}
