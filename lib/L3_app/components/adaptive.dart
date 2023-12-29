// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../main.dart';
import 'constants.dart';

BuildContext get globalContext => rootKey.currentContext!;

Size screenSize(BuildContext context) => MediaQuery.sizeOf(context);
EdgeInsets screenPadding(BuildContext context) => MediaQuery.paddingOf(context);
bool _smallLandscape(BuildContext context) =>
    screenSize(context).height < SCR_XS_HEIGHT && MediaQuery.orientationOf(context) == Orientation.landscape;

bool isBigScreen(BuildContext context) {
  final size = screenSize(context);
  return size.height > SCR_S_HEIGHT && size.width > SCR_M_WIDTH;
}

bool canShowVerticalBars(BuildContext context) => isBigScreen(context) || _smallLandscape(context);

enum AdaptiveSize { XXS, XS, S, M, L }

class MTAdaptive extends StatelessWidget {
  const MTAdaptive({required this.child, this.force = false, this.size = AdaptiveSize.M});

  const MTAdaptive.xxs({required this.child, this.force = true}) : size = AdaptiveSize.XXS;
  const MTAdaptive.xs({required this.child, this.force = true}) : size = AdaptiveSize.XS;
  const MTAdaptive.s({required this.child, this.force = false}) : size = AdaptiveSize.S;
  const MTAdaptive.l({required this.child, this.force = false}) : size = AdaptiveSize.L;

  final Widget? child;
  final bool force;
  final AdaptiveSize size;

  Widget _constrained(BuildContext context) {
    double W = SCR_XXS_WIDTH;

    switch (size) {
      case AdaptiveSize.XXS:
        break;
      case AdaptiveSize.XS:
        W = SCR_XS_WIDTH;
        break;
      case AdaptiveSize.S:
        W = SCR_S_WIDTH;
        break;
      case AdaptiveSize.M:
        W = SCR_M_WIDTH;
        break;
      case AdaptiveSize.L:
        W = SCR_L_WIDTH;
        break;
    }

    final mqW = MediaQuery.sizeOf(context).width;
    return Container(
      alignment: isBigScreen(context) ? Alignment.topLeft : Alignment.topCenter,
      child: SizedBox(
        width: min(W, mqW),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return force ? UnconstrainedBox(child: _constrained(context)) : _constrained(context);
  }
}

double defaultImageHeight(BuildContext context) => min(200, max(120, MediaQuery.sizeOf(context).height / 3.5));
