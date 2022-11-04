// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';

class MTProgressMark {
  const MTProgressMark({
    this.size,
    this.color,
    required this.child,
  });
  final Color? color;

  @protected
  final Size? size;

  @protected
  final Widget child;
}

class MTProgress extends StatelessWidget {
  const MTProgress({
    required this.value,
    this.color,
    this.height,
    this.mark,
    this.border,
  });

  final double value;
  final Color? color;
  final double? height;
  final MTProgressMark? mark;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      final rWidth = value * size.maxWidth;
      return Stack(clipBehavior: Clip.none, children: [
        Positioned(
          top: height != null ? null : 0,
          bottom: 0,
          height: height != null ? height : null,
          width: rWidth,
          child: Container(
            decoration: BoxDecoration(
              color: color?.maybeResolve(context),
              border: border ?? const Border(),
            ),
          ),
        ),
        if (mark != null)
          Positioned(
            left: rWidth - (mark!.size?.width ?? 0) / 2 - (border?.right.width ?? 0) / 2,
            top: mark!.size?.height,
            child: mark!.child,
          ),
      ]);
    });
  }
}
