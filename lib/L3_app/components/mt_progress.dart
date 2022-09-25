// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';
import 'icons.dart';

class MTProgressMark extends StatelessWidget {
  const MTProgressMark({
    this.size,
    this.color,
    this.showTop,
    this.showBottom,
    this.child,
  }) : assert(showTop == true || showBottom == true);
  @protected
  final Color? color;
  @protected
  final Size? size;
  @protected
  final Widget? child;

  final bool? showTop;
  final bool? showBottom;

  Size get mSize => size ?? Size(onePadding * 0.5, onePadding * 0.7);

  @override
  Widget build(BuildContext context) {
    return child ?? caretIcon(context, up: showBottom == true, size: mSize);
  }
}

class MTProgress extends StatelessWidget {
  const MTProgress({
    required this.value,
    this.child,
    this.color,
    this.border,
    this.bgColor,
    this.padding,
    this.height,
    this.mark,
  });

  final double value;
  final Color? color;
  final Border? border;
  final Widget? child;
  final Color? bgColor;
  final EdgeInsets? padding;
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
          child: Container(
            decoration: BoxDecoration(
              color: (color ?? borderColor).resolve(context),
              border: border ?? const Border(),
            ),
          ),
        ),
        Padding(
          padding: padding ?? EdgeInsets.all(onePadding),
          child: Row(children: [
            if (child != null) Expanded(child: child!),
          ]),
        ),
        if (mark?.showTop == true)
          Positioned(
            left: rWidth - mark!.mSize.width / 2,
            top: -mark!.mSize.height,
            child: mark!,
          ),
        if (mark?.showBottom == true)
          Positioned(
            left: rWidth - mark!.mSize.width / 2,
            bottom: -mark!.mSize.height,
            child: mark!,
          ),
      ]);
    });
  }
}
