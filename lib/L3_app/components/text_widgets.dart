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
    this.height,
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
  final double? height;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? align;
  final EdgeInsets? padding;
  final TextDecoration? decoration;

  TextStyle style(BuildContext context) {
    final cupertinoTS = CupertinoTheme.of(context).textTheme.textStyle;
    return cupertinoTS.copyWith(
      color: CupertinoDynamicColor.maybeResolve(color ?? darkColor, context),
      fontWeight: weight ?? cupertinoTS.fontWeight,
      fontSize: (cupertinoTS.fontSize ?? (isTablet ? 22 : 14)) * (sizeScale ?? 1),
      height: height ?? cupertinoTS.height,
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
    FontWeight? weight,
    int? maxLines,
    TextAlign? align,
    EdgeInsets? padding,
    TextDecoration? decoration,
  }) : super(
          text,
          color: color ?? darkGreyColor,
          weight: weight,
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
          maxLines: maxLines ?? 4,
          sizeScale: sizeScale,
          align: align,
          padding: padding,
          decoration: decoration,
        );
}

class MediumText extends NormalText {
  const MediumText(
    String text, {
    Color? color,
    double? sizeScale,
    int? maxLines,
    TextAlign? align,
    EdgeInsets? padding,
    TextDecoration? decoration,
  }) : super(
          text,
          color: color,
          weight: FontWeight.w400,
          maxLines: maxLines ?? 4,
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
          sizeScale: 1.1,
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
          weight: FontWeight.w500,
          sizeScale: 1.2,
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
          sizeScale: 1.6,
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
          color: color ?? darkGreyColor,
          weight: FontWeight.w200,
          sizeScale: 2.6,
          maxLines: maxLines ?? 2,
          align: align,
          padding: padding,
          decoration: decoration,
        );
}
