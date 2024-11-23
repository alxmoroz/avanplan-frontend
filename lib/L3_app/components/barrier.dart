// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';
import 'gesture.dart';

class MTBarrier extends StatelessWidget {
  const MTBarrier({
    required this.child,
    this.visible = false,
    this.duration = KB_RELATED_ANIMATION_DURATION,
    this.margin,
    this.color = defaultKBBarrierColor,
    super.key,
  });
  final Widget child;
  final bool visible;
  final Duration duration;
  final EdgeInsets? margin;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: AnimatedOpacity(
            opacity: visible ? 1 : 0,
            duration: duration,
            child: IgnorePointer(
              ignoring: !visible,
              child: FocusDroppable(
                Container(
                  margin: margin,
                  color: color.resolve(context),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
