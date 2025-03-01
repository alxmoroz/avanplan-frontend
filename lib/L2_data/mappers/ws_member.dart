// Copyright (c) 2024. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as api;

import '../../L1_domain/entities/ws_member.dart';

extension MemberMapper on api.MemberGet {
  WSMember wsMember(int wsId) => WSMember(
        id: id,
        wsId: wsId,
        userId: userId,
        email: email,
        fullName: fullName ?? '',
        roles: roleCodes ?? [],
        permissions: permissionCodes ?? [],
      );
}
