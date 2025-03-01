// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as o_api;

import '../../L1_domain/entities/ws_member_contact.dart';

extension WSMemberContactMapper on o_api.MemberContactGet {
  WSMemberContact get memberContact => WSMemberContact(
        id: id,
        memberId: memberId,
        value: value,
        description: description ?? '',
      );
}
