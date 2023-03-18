// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/member.dart';

extension MemberMapper on api.MemberGet {
  Member member(int taskId) => Member(
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
