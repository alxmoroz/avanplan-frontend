// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'constants.dart';

enum _AdaptiveSize { S, M, L }

class MTAdaptive extends StatelessWidget {
  const MTAdaptive(this.child, {this.size = _AdaptiveSize.M, this.force = false});

  const MTAdaptive.S(this.child, {this.force = true}) : size = _AdaptiveSize.S;
  const MTAdaptive.L(this.child, {this.force = false}) : size = _AdaptiveSize.L;

  final Widget? child;
  final bool force;
  final _AdaptiveSize size;

  @override
  Widget build(BuildContext context) {
    Widget _constrained() {
      double W = SCR_S_WIDTH * 0.8;

      switch (size) {
        case _AdaptiveSize.S:
          break;
        case _AdaptiveSize.M:
          W = SCR_M_WIDTH;
          break;
        case _AdaptiveSize.L:
          W = SCR_L_WIDTH;
          break;
      }

      return Container(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: min(W, MediaQuery.of(context).size.width),
          child: child,
        ),
      );
    }

    return force ? UnconstrainedBox(child: _constrained()) : _constrained();
  }
}
