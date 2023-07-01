// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'constants.dart';

enum _AdaptiveSize { XS, S, M, L }

class MTAdaptive extends StatelessWidget {
  const MTAdaptive({required this.child, this.padding, this.force = false}) : size = _AdaptiveSize.M;

  const MTAdaptive.XS(this.child, {this.padding, this.force = true}) : size = _AdaptiveSize.XS;
  const MTAdaptive.S(this.child, {this.padding, this.force = false}) : size = _AdaptiveSize.S;
  const MTAdaptive.L(this.child, {this.padding, this.force = false}) : size = _AdaptiveSize.L;

  final Widget? child;
  final bool force;
  final _AdaptiveSize size;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    Widget _constrained() {
      double W = SCR_XS_WIDTH * 0.9;

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

    return force ? UnconstrainedBox(child: _constrained()) : _constrained();
  }
}

double dashboardImageSize(BuildContext context) => min(P * 17, MediaQuery.of(context).size.height / 2.5);
