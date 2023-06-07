// Copyright (c) 2022. Alexandr Moroz

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

  Widget get _constrained {
    double _maxW = SCR_S_WIDTH * 0.8;
    double _minW = SCR_S_WIDTH * 0.8;

    switch (size) {
      case _AdaptiveSize.S:
        break;
      case _AdaptiveSize.M:
        _minW = SCR_M_WIDTH;
        _maxW = SCR_M_WIDTH;
        break;
      case _AdaptiveSize.L:
        _minW = SCR_L_WIDTH;
        _maxW = SCR_L_WIDTH;
        break;
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: _minW,
        maxWidth: _maxW,
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return force ? UnconstrainedBox(child: _constrained) : _constrained;
  }
}
