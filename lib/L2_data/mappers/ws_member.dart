// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/ws_member.dart';
import 'user_activity.dart';

extension WSMemberMapper on api.User {
  WSMember wsMember(int wsId) => WSMember(
        wsId: wsId,
        id: id,
        email: email,
        fullName: fullName ?? '',
        roles: roleCodes ?? [],
        permissions: permissionCodes ?? [],
        activities: [],
      );
}

extension MyUserMapper on api.MyUser {
  WSMember myUser(int wsId) => WSMember(
        wsId: wsId,
        id: id,
        email: email,
        fullName: fullName ?? '',
        roles: [],
        permissions: [],
        activities: activities.map((a) => a.activity),
      );
}
