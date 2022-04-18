// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';

class NormalText extends StatelessWidget {
  const NormalText(
    this.text, {
    this.size,
    this.sizeScale,
    this.color,
    this.weight,
    this.align,
    this.padding,
    this.height,
    this.overflow,
    this.maxLines,
    this.decoration,
  });

  final String text;
  final Color? color;
  final FontWeight? weight;
  final TextAlign? align;
  final double? size;
  final double? sizeScale;
  final EdgeInsets? padding;
  final double? height;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? decoration;

  TextStyle style(BuildContext context) {
    final cupertinoTS = CupertinoTheme.of(context).textTheme.textStyle;
    return cupertinoTS.copyWith(
      color: CupertinoDynamicColor.maybeResolve(color ?? darkColor, context),
      fontWeight: weight ?? cupertinoTS.fontWeight,
      fontSize: (size ?? cupertinoTS.fontSize ?? (isTablet ? 22 : 14)) * (sizeScale ?? 1),
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
    TextAlign? align,
    EdgeInsets? padding,
    double? sizeScale,
    int? maxLines,
    TextDecoration? decoration,
  }) : super(
          text,
          color: color ?? darkGreyColor,
          weight: weight,
          sizeScale: sizeScale ?? 0.85,
          align: align,
          padding: padding,
          maxLines: maxLines ?? 5,
          decoration: decoration,
        );
}

class LightText extends NormalText {
  const LightText(
    String text, {
    double? size,
    Color? color,
    FontWeight? weight,
    TextAlign? align,
    EdgeInsets? padding,
    double? sizeScale,
    int? maxLines,
    TextDecoration? decoration,
  }) : super(
          text,
          color: color,
          weight: weight ?? FontWeight.w300,
          size: size,
          sizeScale: sizeScale,
          align: align,
          padding: padding,
          maxLines: maxLines ?? 5,
          decoration: decoration,
        );
}

class MediumText extends NormalText {
  const MediumText(
    String text, {
    double? size,
    Color? color,
    FontWeight? weight,
    TextAlign? align,
    EdgeInsets? padding,
    double? sizeScale,
    int? maxLines,
    TextDecoration? decoration,
  }) : super(
          text,
          color: color,
          weight: weight ?? FontWeight.w500,
          size: size,
          sizeScale: sizeScale,
          align: align,
          padding: padding,
          maxLines: maxLines ?? 4,
          decoration: decoration,
        );
}

class H4 extends MediumText {
  const H4(
    String text, {
    Color? color,
    FontWeight? weight,
    TextAlign? align,
    EdgeInsets? padding,
    int? maxLines,
    TextDecoration? decoration,
  }) : super(
          text,
          color: color,
          weight: weight,
          sizeScale: 1.1,
          align: align,
          padding: padding,
          maxLines: maxLines ?? 3,
          decoration: decoration,
        );
}

class H3 extends MediumText {
  const H3(
    String text, {
    Color? color,
    FontWeight? weight,
    TextAlign? align,
    EdgeInsets? padding,
    int? maxLines,
    TextDecoration? decoration,
  }) : super(
          text,
          color: color,
          weight: weight,
          sizeScale: 1.2,
          align: align,
          padding: padding,
          maxLines: maxLines ?? 3,
          decoration: decoration,
        );
}

class H2 extends MediumText {
  const H2(
    String text, {
    Color? color,
    FontWeight? weight,
    TextAlign? align,
    EdgeInsets? padding,
    int? maxLines,
    TextDecoration? decoration,
  }) : super(
          text,
          color: color ?? darkGreyColor,
          weight: weight,
          sizeScale: 1.5,
          align: align,
          padding: padding,
          maxLines: maxLines ?? 3,
          decoration: decoration,
        );
}

class H1 extends MediumText {
  const H1(
    String text, {
    Color? color,
    FontWeight? weight,
    TextAlign? align,
    EdgeInsets? padding,
    int? maxLines,
    TextDecoration? decoration,
  }) : super(
          text,
          color: color ?? darkGreyColor,
          weight: weight,
          sizeScale: 2.5,
          align: align,
          padding: padding,
          maxLines: maxLines ?? 2,
          decoration: decoration,
        );
}
