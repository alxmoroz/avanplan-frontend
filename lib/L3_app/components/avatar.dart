// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/user.dart';
import '../../L2_data/services/api.dart';
import '../components/colors.dart';
import '../components/colors_base.dart';
import '../components/icons.dart';

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
    final bColor = borderColor ?? f3Color;
    return CircleAvatar(
      radius: radius,
      backgroundColor: bColor.resolve(context),
      child: CircleAvatar(
        radius: radius - 2,
        backgroundColor: b3Color.resolve(context),
        child: Stack(
          alignment: Alignment.center,
          children: [
            PersonNoAvatarIcon(size: radius * 1.3, color: bColor),
            CircleAvatar(
              radius: radius - 3,
              backgroundColor: Colors.transparent,
              backgroundImage: !_hasAvatar && user != null ? NetworkImage(_gravatarUrl) : null,
              foregroundImage: _hasAvatar ? NetworkImage(_avatarUrl) : null,
            ),
          ],
        ),
      ),
    );
  }
}
