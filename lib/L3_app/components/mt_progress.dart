// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';

class MTProgressMark extends StatelessWidget {
  const MTProgressMark({
    this.size,
    this.color,
    this.child,
  });
  @protected
  final Color? color;
  @protected
  final Size? size;
  @protected
  final Widget? child;

  Size get mSize => size ?? const Size(2, 0);

  @override
  Widget build(BuildContext context) =>
      child ?? Container(height: onePadding * 3, width: mSize.width, color: (color ?? borderColor).resolve(context));
}

class MTProgress extends StatelessWidget {
  const MTProgress({
    required this.value,
    this.color,
    this.bgColor,
    this.height,
    this.mark,
  });

  final double value;
  final Color? color;
  final Color? bgColor;
  final double? height;
  final MTProgressMark? mark;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      final rWidth = value * size.maxWidth;
      return Stack(clipBehavior: Clip.none, children: [
        if (bgColor != null)
          Positioned(
            top: 0,
            bottom: 0,
            width: size.maxWidth,
            child: Container(color: bgColor!.resolve(context)),
          ),
        Positioned(
          top: height != null ? null : 0,
          bottom: 0,
          height: height != null ? height : null,
          width: rWidth,
          child: Container(color: (color ?? darkBackgroundColor).resolve(context)),
        ),
        if (mark != null)
          Positioned(
            left: rWidth - mark!.mSize.width / 2,
            top: -mark!.mSize.height,
            child: mark!,
          ),
      ]);
    });
  }
}
