// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/member.dart';

extension MemberMapper on api.MemberGet {
  WSMember wsMember(int wsId) => WSMember(
        id: id,
        wsId: wsId,
        userId: userId,
        email: email,
        fullName: fullName,
        roles: [],
        permissions: [],
        isActive: isActive == true,
      );

  TaskMember taskMember(int wsId, int taskId) => TaskMember(
        id: id,
        wsId: wsId,
        taskId: taskId,
        userId: userId,
        email: email,
        fullName: fullName,
        roles: roleCodes ?? [],
        permissions: permissionCodes ?? [],
        isActive: isActive == true,
      );
}
