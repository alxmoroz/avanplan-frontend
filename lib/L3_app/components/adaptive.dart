// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'constants.dart';

enum _AdaptiveSize { XS, S, M, L }

class MTAdaptive extends StatelessWidget {
  const MTAdaptive({required this.child, this.padding, this.force = false}) : size = _AdaptiveSize.M;

  const MTAdaptive.xs({required this.child, this.padding, this.force = true}) : size = _AdaptiveSize.XS;
  const MTAdaptive.s({required this.child, this.padding, this.force = false}) : size = _AdaptiveSize.S;
  const MTAdaptive.l({required this.child, this.padding, this.force = false}) : size = _AdaptiveSize.L;

  final Widget? child;
  final bool force;
  final _AdaptiveSize size;
  final EdgeInsets? padding;

  Widget _constrained(BuildContext context) {
    double W = SCR_XS_WIDTH * 0.8;

    switch (size) {
      case _AdaptiveSize.XS:
        break;
      case _AdaptiveSize.S:
        W = SCR_S_WIDTH;
        break;
      case _AdaptiveSize.M:
        W = SCR_M_WIDTH;
        break;
      case _AdaptiveSize.L:
        W = SCR_L_WIDTH;
        break;
    }

    final mqW = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: min(W, mqW),
        child: Padding(
          padding: W >= mqW ? (padding ?? EdgeInsets.zero) : EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return force ? UnconstrainedBox(child: _constrained(context)) : _constrained(context);
  }
}

double dashboardImageHeight(BuildContext context) => min(200, MediaQuery.of(context).size.height / 2.5);

double bottomPadding(BuildContext context) => max(MediaQuery.paddingOf(context).bottom, P6);

bool isBigScreen(BuildContext context) {
  final mq = MediaQuery.of(context);
  final mqH = mq.size.height;
  final mqW = mq.size.width;
  return mqH > SCR_S_HEIGHT && mqW > SCR_M_WIDTH;
}
