// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';

class MTShadowed extends StatelessWidget {
  const MTShadowed({
    required this.child,
    this.shadowColor,
    this.topShadow = true,
    this.bottomShadow = false,
  });

  final Widget child;
  final bool topShadow;
  final bool bottomShadow;
  final Color? shadowColor;

  Widget _shadow(BuildContext context, bool top) {
    final padding = MediaQuery.of(context).padding;
    final startColor = (shadowColor ?? bgL2Color).resolve(context);
    final endColor = startColor.withAlpha(0);
    return Positioned(
      left: 0,
      right: 0,
      top: top ? padding.top : null,
      bottom: top ? null : padding.bottom,
      height: P * 1,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: top ? Alignment.topCenter : Alignment.bottomCenter,
            end: top ? Alignment.bottomCenter : Alignment.topCenter,
            colors: [startColor, endColor],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (topShadow) _shadow(context, true),
        if (bottomShadow) _shadow(context, false),
      ],
    );
  }
}
