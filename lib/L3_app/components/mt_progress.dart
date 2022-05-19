// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';
import 'text_widgets.dart';

class MTProgress extends StatelessWidget {
  const MTProgress({
    required this.ratio,
    required this.body,
    this.width,
    this.color,
    this.bgColor,
    this.padding,
  });

  final double ratio;
  final Color? color;
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
        child: Container(color: (color ?? borderColor).resolve(context)),
      ),
      if (body != null)
        Padding(
          padding: padding ?? EdgeInsets.all(onePadding),
          child: body!,
        ),
    ]);
  }
}

class SampleProgress extends MTProgress {
  SampleProgress({
    required double ratio,
    required Color? color,
    required String titleText,
    String? trailingText,
    String? subtitleText,
    Color? bgColor,
  }) : super(
          color: color,
          bgColor: bgColor ?? navbarBgColor,
          ratio: ratio,
          padding: EdgeInsets.symmetric(vertical: onePadding / 2, horizontal: onePadding),
          body: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  H4(titleText),
                  if (subtitleText != null) SmallText(subtitleText),
                ],
              ),
            ),
            if (trailingText != null) H2(trailingText),
          ]),
        );
}
