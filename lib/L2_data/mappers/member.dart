// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/member.dart';

extension MemberMapper on api.MemberGet {
  WSMember get wsMember => WSMember(
        id: id,
        email: email,
        fullName: fullName,
        roles: [],
        permissions: [],
        isActive: isActive == true,
        userId: userId,
      );

  TaskMember taskMember(int taskId) => TaskMember(
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
