// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';

class NormalText extends StatelessWidget {
  const NormalText(
    this.text, {
    this.sizeScale,
    this.color,
    this.weight,
    this.overflow,
    this.maxLines,
    this.align,
    this.padding,
    this.decoration,
  });

  final String text;
  final double? sizeScale;
  final Color? color;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? align;
  final EdgeInsets? padding;
  final TextDecoration? decoration;

  TextStyle style(BuildContext context) {
    final cupertinoTS = CupertinoTheme.of(context).textTheme.textStyle;
    return cupertinoTS.copyWith(
      color: CupertinoDynamicColor.maybeResolve(color ?? darkColor, context),
      fontWeight: weight ?? FontWeight.w400,
      fontSize: (cupertinoTS.fontSize ?? (isTablet ? 24 : 17)) * (sizeScale ?? 1),
      inherit: true,
      decoration: decoration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text,
        style: style(context),
        textAlign: align,
        maxLines: maxLines ?? 100,
        overflow: overflow ?? TextOverflow.ellipsis,
      ),
    );
  }
}

class SmallText extends NormalText {
  const SmallText(
    String text, {
    Color? color,
    int? maxLines,
    TextAlign? align,
    EdgeInsets? padding,
    TextDecoration? decoration,
  }) : super(
          text,
          color: color,
          sizeScale: 0.85,
          maxLines: maxLines ?? 7,
          align: align,
          padding: padding,
          decoration: decoration,
        );
}

class LightText extends NormalText {
  const LightText(
    String text, {
    Color? color,
    int? maxLines,
    double? sizeScale,
    TextAlign? align,
    EdgeInsets? padding,
    TextDecoration? decoration,
  }) : super(
          text,
          color: color,
          weight: FontWeight.w300,
          maxLines: maxLines ?? 5,
          sizeScale: sizeScale,
          align: align,
          padding: padding,
          decoration: decoration,
        );
}

class H4 extends NormalText {
  const H4(
    String text, {
    Color? color,
    int? maxLines,
    TextAlign? align,
    EdgeInsets? padding,
    TextDecoration? decoration,
  }) : super(
          text,
          color: color ?? darkGreyColor,
          weight: FontWeight.w400,
          sizeScale: 1.2,
          maxLines: maxLines ?? 4,
          align: align,
          padding: padding,
          decoration: decoration,
        );
}

class H3 extends NormalText {
  const H3(
    String text, {
    Color? color,
    int? maxLines,
    TextAlign? align,
    EdgeInsets? padding,
    TextDecoration? decoration,
  }) : super(
          text,
          color: color ?? darkGreyColor,
          weight: FontWeight.w400,
          sizeScale: 1.6,
          maxLines: maxLines ?? 3,
          align: align,
          padding: padding,
          decoration: decoration,
        );
}

class H2 extends NormalText {
  const H2(
    String text, {
    Color? color,
    int? maxLines,
    TextAlign? align,
    EdgeInsets? padding,
    TextDecoration? decoration,
  }) : super(
          text,
          color: color ?? darkGreyColor,
          weight: FontWeight.w300,
          sizeScale: 2.0,
          maxLines: maxLines ?? 3,
          align: align,
          padding: padding,
          decoration: decoration,
        );
}

class H1 extends NormalText {
  const H1(
    String text, {
    Color? color,
    int? maxLines,
    TextAlign? align,
    EdgeInsets? padding,
    TextDecoration? decoration,
  }) : super(
          text,
          color: color,
          weight: FontWeight.w200,
          sizeScale: 2.7,
          maxLines: maxLines ?? 2,
          align: align,
          padding: padding,
          decoration: decoration,
        );
}
