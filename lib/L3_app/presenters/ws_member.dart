// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/member.dart';
import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities_extensions/ws_users.dart';
import '../components/avatar.dart';
import '../components/colors.dart';
import '../components/colors_base.dart';
import '../extra/services.dart';

extension WSMemberPresenter on WSMember {
  User? get user => userId != null ? wsMainController.ws(wsId)?.userForId(userId!) : null;
  Widget icon(double radius) => MTAvatar(user: user, radius, borderColor: isTaskMember ? mainColor : f3Color);
}
