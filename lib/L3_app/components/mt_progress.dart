// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';
import 'text_widgets.dart';

class MTProgress extends StatelessWidget {
  const MTProgress({
    required this.ratio,
    required this.body,
    this.color,
    this.bgColor,
    this.padding,
    this.height,
  });

  final double ratio;
  final Color? color;
  final Widget? body;
  final Color? bgColor;
  final EdgeInsets? padding;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      final rWidth = ratio * size.maxWidth;
      return Stack(children: [
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
          child: Container(color: (color ?? borderColor).resolve(context)),
        ),
        if (body != null)
          Padding(
            padding: padding ?? EdgeInsets.all(onePadding),
            child: body!,
          ),
      ]);
    });
  }
}

class SampleProgress extends MTProgress {
  SampleProgress({
    required double ratio,
    required String titleText,
    String? trailingText,
    Color? color,
    Color? bgColor,
  }) : super(
          color: color,
          bgColor: bgColor ?? navbarBgColor,
          ratio: ratio,
          padding: EdgeInsets.symmetric(vertical: onePadding / 3, horizontal: onePadding),
          body: Row(children: [
            Expanded(child: NormalText(titleText)),
            if (trailingText != null) H4(trailingText),
          ]),
        );
}
