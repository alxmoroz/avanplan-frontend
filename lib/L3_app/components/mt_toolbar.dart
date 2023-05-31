// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';

class MTToolbar extends StatelessWidget {
  const MTToolbar({required this.child, this.color});
  final Widget child;
  final Color? color;

  static const double _topPadding = P;
  static double _bottomPadding(BuildContext context) => max(MediaQuery.of(context).padding.bottom, P2);
  static double minHeight(BuildContext context) => _bottomPadding(context) + _topPadding;

  @override
  Widget build(BuildContext context) => ClipRect(
        child: Container(
          padding: EdgeInsets.only(top: _topPadding, bottom: _bottomPadding(context)),
          color: (color ?? navbarDefaultBgColor).resolve(context),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: child,
          ),
        ),
      );
}
