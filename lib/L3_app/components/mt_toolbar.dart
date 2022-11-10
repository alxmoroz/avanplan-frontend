// Copyright (c) 2022. Alexandr Moroz

import 'dart:ui';

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';

class MTToolbar extends StatelessWidget {
  const MTToolbar({required this.child, this.color});
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding.bottom;

    return ClipRect(
      child: Container(
        padding: EdgeInsets.only(top: P_2, bottom: safePadding > 0 ? 0 : P * 1.4),
        color: (color ?? navbarDefaultBgColor).resolve(context),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: BottomAppBar(
            elevation: 0,
            color: Colors.transparent,
            child: child,
          ),
        ),
      ),
    );
  }
}
