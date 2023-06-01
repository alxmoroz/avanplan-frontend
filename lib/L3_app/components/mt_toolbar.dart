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

  static double bottomPadding = P2;
  static double get topPadding => P;

  @override
  Widget build(BuildContext context) {
    bottomPadding = max(MediaQuery.of(context).padding.bottom, P2);
    return ClipRect(
      child: Container(
        color: (color ?? navbarDefaultBgColor).resolve(context),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: EdgeInsets.only(
              top: topPadding,
              bottom: bottomPadding,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
