// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';

class MTProgress extends StatelessWidget {
  const MTProgress({
    required this.ratio,
    required this.color,
    required this.body,
    this.width,
    this.bgColor,
    this.padding,
  });

  final double ratio;
  final Color color;
  final Widget? body;
  final double? width;
  final Color? bgColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Stack(children: [
      if (bgColor != null)
        Positioned(
          top: 0,
          bottom: 0,
          width: mq.size.width,
          child: Container(color: bgColor!.resolve(context)),
        ),
      Positioned(
        top: 0,
        bottom: 0,
        width: ratio * (width ?? mq.size.width),
        child: Container(color: color.resolve(context)),
      ),
      if (body != null)
        Padding(
          padding: padding ?? EdgeInsets.all(onePadding),
          child: body!,
        ),
    ]);
  }
}
