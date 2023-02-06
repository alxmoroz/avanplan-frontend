// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/member.dart';
import 'role.dart';

extension MemberMapper on api.MemberGet {
  Member get member => Member(
        id: id,
        email: email,
        fullName: fullName,
        roles: roles?.map((r) => r.role).toList() ?? [],
        isActive: isActive == true,
      );
}
