// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/member.dart';

extension MemberMapper on api.MemberGet {
  Member member(int wsId) => Member(
        id: id,
        email: email,
        fullName: fullName,
        wsId: wsId,
        userId: userId,
      );
}
