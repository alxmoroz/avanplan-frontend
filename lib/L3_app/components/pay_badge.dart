// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'icons_workspace.dart';

class MTPayBadge extends StatelessWidget {
  const MTPayBadge({this.iconSize = P4});
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final _badgeSize = iconSize + P;
    return Container(
      margin: EdgeInsets.only(left: iconSize / 2, right: P),
      padding: const EdgeInsets.only(top: P_3),
      height: _badgeSize,
      width: _badgeSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_badgeSize / 2),
        color: warningColor.resolve(context),
      ),
      child: RoubleIcon(size: iconSize, color: f1Color),
    );
  }
}
