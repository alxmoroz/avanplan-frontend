// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/ws_member_contact.dart';

extension WSMemberContactMapper on o_api.MemberContactGet {
  WSMemberContact get memberContact => WSMemberContact(
        id: id,
        memberId: memberId,
        value: value,
      );
}
