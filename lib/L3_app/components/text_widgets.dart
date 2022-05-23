// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';

class _BaseText extends StatelessWidget {
  const _BaseText(
    this.text, {
    this.sizeScale,
    this.color,
    this.weight,
    this.maxLines,
    this.align,
    this.padding,
    this.decoration,
  });

  final String text;
  final double? sizeScale;
  final Color? color;
  final FontWeight? weight;
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
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class SmallText extends _BaseText {
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
          maxLines: maxLines ?? 9,
          align: align,
          padding: padding,
          decoration: decoration,
        );
}

class LightText extends _BaseText {
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
          maxLines: maxLines ?? 7,
          sizeScale: sizeScale,
          align: align,
          padding: padding,
          decoration: decoration,
        );
}

class NormalText extends _BaseText {
  const NormalText(
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
          weight: FontWeight.w400,
          maxLines: maxLines ?? 7,
          sizeScale: sizeScale,
          align: align,
          padding: padding,
          decoration: decoration,
        );
}

class MediumText extends _BaseText {
  const MediumText(
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
          weight: FontWeight.w500,
          maxLines: maxLines ?? 5,
          sizeScale: sizeScale,
          align: align,
          padding: padding,
          decoration: decoration,
        );
}

class H4 extends _BaseText {
  const H4(
    String text, {
    Color? color,
    int? maxLines,
    TextAlign? align,
    EdgeInsets? padding,
    TextDecoration? decoration,
  }) : super(
          text,
          color: color,
          weight: FontWeight.w400,
          sizeScale: 1.2,
          maxLines: maxLines ?? 3,
          align: align,
          padding: padding,
          decoration: decoration,
        );
}

class H3 extends _BaseText {
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

class H2 extends _BaseText {
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

class H1 extends _BaseText {
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
          sizeScale: 2.45,
          maxLines: maxLines ?? 2,
          align: align,
          padding: padding,
          decoration: decoration,
        );
}
