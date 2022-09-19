// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';
import 'icons.dart';

class MTProgress extends StatelessWidget {
  const MTProgress({
    required this.value,
    this.child,
    this.color,
    this.border,
    this.bgColor,
    this.padding,
    this.height,
    this.showTopMark = false,
    this.showBottomMark = false,
    this.markSize,
  }) : assert(((showTopMark || showBottomMark) && markSize != null) || !(showTopMark && showBottomMark));

  final double value;
  final Color? color;
  final Border? border;
  final Widget? child;
  final Color? bgColor;
  final EdgeInsets? padding;
  final double? height;
  final bool showTopMark;
  final bool showBottomMark;
  final Size? markSize;

  Size get _markSize => markSize ?? Size(onePadding, onePadding);

  Widget _mark(BuildContext context, bool up) => caretIcon(context, up: up, size: _markSize);

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
        if (showTopMark)
          Positioned(
            left: rWidth - _markSize.width / 2,
            top: -_markSize.height,
            child: _mark(context, false),
          ),
        if (showBottomMark)
          Positioned(
            left: rWidth - _markSize.width / 2,
            bottom: -_markSize.height,
            child: _mark(context, true),
          ),
      ]);
    });
  }
}

// class SampleProgress extends MTProgress {
//   SampleProgress({
//     required double ratio,
//     required String titleText,
//     String? trailingText,
//     Color? color,
//     Color? bgColor,
//   }) : super(
//           color: color,
//           bgColor: bgColor ?? navbarBgColor,
//           value: ratio,
//           padding: EdgeInsets.symmetric(vertical: onePadding / 3, horizontal: onePadding),
//           child: Row(children: [
//             Expanded(child: NormalText(titleText)),
//             if (trailingText != null) H4(trailingText),
//           ]),
//         );
// }
