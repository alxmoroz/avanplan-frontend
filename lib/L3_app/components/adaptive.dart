// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'constants.dart';

bool isBigScreen(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
  return size.height > SCR_S_HEIGHT && size.width > SCR_M_WIDTH;
}

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
    final big = isBigScreen(context);
    return Container(
      alignment: big ? Alignment.topLeft : Alignment.topCenter,
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

double bottomPadding(BuildContext context) => max(MediaQuery.paddingOf(context).bottom, P4);

// отображаем боковое меню для больших экранов или в пейзажном режиме для маленькой высоты экрана
bool showSideMenu(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
  return isBigScreen(context) || size.height < SCR_XS_HEIGHT;
}
