// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/user.dart';
import '../../L2_data/services/api.dart';
import '../components/colors.dart';
import '../components/colors_base.dart';
import '../components/icons.dart';
import 'constants.dart';

const double MAX_AVATAR_RADIUS = SCR_S_WIDTH / 4;

class MTAvatar extends StatelessWidget {
  const MTAvatar(
    this.radius, {
    this.user,
    this.borderColor,
    super.key,
  });
  final double radius;
  final Color? borderColor;
  final User? user;

  bool get _hasAvatar => user?.hasAvatar == true;

  String get _salt => '${user?.updatedOn?.millisecondsSinceEpoch ?? ''}';
  String? get _fileName => user?.emailMD5;
  String get _gravatarUrl => 'https://www.gravatar.com/avatar/$_fileName?s=${radius * 6}&d=blank';
  String get _avatarUrl => '${openAPI.dio.options.baseUrl}/v1/avatars/download/$_fileName?$_salt';

  @override
  Widget build(BuildContext context) {
    bool hasBorder = borderColor != null;
    final avatar = Stack(
      alignment: Alignment.center,
      children: [
        PersonNoAvatarIcon(size: radius * 2 - (hasBorder ? 4 : 2), color: user != null ? f3Color : f3Color, circled: true),
        CircleAvatar(
          radius: radius - (hasBorder ? 2 : 0),
          backgroundColor: Colors.transparent,
          backgroundImage: !_hasAvatar && user != null ? NetworkImage(_gravatarUrl) : null,
          foregroundImage: _hasAvatar ? NetworkImage(_avatarUrl) : null,
        ),
      ],
    );
    return hasBorder
        ? CircleAvatar(
            radius: radius,
            backgroundColor: borderColor!.resolve(context),
            child: avatar,
          )
        : avatar;
  }
}
