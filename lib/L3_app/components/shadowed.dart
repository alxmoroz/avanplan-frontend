// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';

class MTShadowed extends StatelessWidget {
  const MTShadowed({
    required this.child,
    this.shadowColor,
    this.topShadow = true,
    this.bottomShadow = false,
    this.topPaddingIndent = P3,
    this.bottomPaddingIndent = P3,
  });

  final Widget child;
  final Color? shadowColor;
  final bool topShadow;
  final bool bottomShadow;
  final double topPaddingIndent;
  final double bottomPaddingIndent;

  Widget _shadow(BuildContext context, bool top) {
    final padding = MediaQuery.paddingOf(context);
    final startColor = (shadowColor ?? b2Color).resolve(context);
    final endColor = startColor.withAlpha(0);
    return Positioned(
      left: 0,
      right: 0,
      top: top ? padding.top : null,
      bottom: top ? null : padding.bottom,
      height: P,
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

  double get _topIndent => topShadow ? topPaddingIndent : 0;
  double get _bottomIndent => bottomShadow ? bottomPaddingIndent : 0;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final mqPadding = mq.padding;
    return Stack(
      children: [
        MediaQuery(
          data: mq.copyWith(
            padding: mqPadding.copyWith(
              top: mqPadding.top + _topIndent,
              bottom: mqPadding.bottom + _bottomIndent,
            ),
          ),
          child: child,
        ),
        if (topShadow) _shadow(context, true),
        if (bottomShadow) _shadow(context, false),
      ],
    );
  }
}
