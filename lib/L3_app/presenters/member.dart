// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/member.dart';
import '../../L1_domain/entities/user.dart';
import '../components/avatar.dart';
import '../extra/services.dart';
import 'workspace.dart';

extension WSMemberPresenter on WSMember {
  Widget icon(double radius, {Color? borderColor}) {
    User? user;
    if (isActive) {
      user = wsMainController.ws(wsId)?.userForId(userId!);
    }
    return MTAvatar(user: user, radius, borderColor: borderColor);
  }
}
