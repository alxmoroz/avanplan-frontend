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
  });

  @protected
  final String text;
  @protected
  final Color? color;
  @protected
  final FontWeight? weight;
  @protected
  final TextAlign? align;
  @protected
  final double? size;
  @protected
  final double? sizeScale;
  @protected
  final EdgeInsets? padding;
  @protected
  final double? height;
  @protected
  final TextOverflow? overflow;
  @protected
  final int? maxLines;

  TextStyle style(BuildContext context) {
    final cupertinoTS = CupertinoTheme.of(context).textTheme.textStyle;
    return cupertinoTS.copyWith(
      color: CupertinoDynamicColor.maybeResolve(color ?? darkColor, context),
      fontWeight: weight ?? cupertinoTS.fontWeight,
      fontSize: (size ?? cupertinoTS.fontSize ?? (isTablet ? 20 : 16)) * (sizeScale ?? 1),
      height: height ?? cupertinoTS.height,
      inherit: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(text, style: style(context), textAlign: align, overflow: overflow),
    );
  }
}

class SmallText extends NormalText {
  const SmallText(String text, {Color? color, FontWeight? weight, TextAlign? align, EdgeInsets? padding, int? maxLines})
      : super(
          text,
          color: color ?? CupertinoColors.systemGrey,
          weight: weight,
          sizeScale: 0.85,
          align: align,
          padding: padding ?? const EdgeInsets.only(top: 4),
          maxLines: maxLines ?? 5,
        );
}

class LightText extends NormalText {
  const LightText(String text,
      {double? size, Color? color, FontWeight? weight, TextAlign? align, EdgeInsets? padding, double? sizeScale, int? maxLines})
      : super(
          text,
          color: color,
          weight: weight ?? FontWeight.w300,
          size: size,
          sizeScale: sizeScale,
          align: align,
          padding: padding,
          maxLines: maxLines ?? 5,
        );
}

class MediumText extends NormalText {
  const MediumText(String text,
      {double? size, Color? color, FontWeight? weight, TextAlign? align, EdgeInsets? padding, double? sizeScale, int? maxLines})
      : super(
          text,
          color: color,
          weight: weight ?? FontWeight.w500,
          size: size,
          sizeScale: sizeScale,
          align: align,
          padding: padding,
          maxLines: maxLines ?? 3,
        );
}

class H3 extends MediumText {
  const H3(String text, {Color? color, FontWeight? weight, TextAlign? align, EdgeInsets? padding, int? maxLines})
      : super(
          text,
          color: color,
          weight: weight,
          sizeScale: 1.2,
          align: align,
          padding: padding,
          maxLines: maxLines ?? 2,
        );
}

class H2 extends MediumText {
  const H2(String text, {Color? color, FontWeight? weight, TextAlign? align, EdgeInsets? padding, int? maxLines})
      : super(
          text,
          color: color,
          weight: weight,
          sizeScale: 1.5,
          align: align,
          padding: padding,
          maxLines: maxLines ?? 2,
        );
}

class H1 extends MediumText {
  H1(String text, {Color? color, FontWeight? weight, TextAlign? align, EdgeInsets? padding, int? maxLines})
      : super(
          text,
          color: color,
          weight: weight,
          sizeScale: 2.5,
          align: align,
          padding: padding ?? EdgeInsets.fromLTRB(0, onePadding, 0, onePadding * 3),
          maxLines: maxLines ?? 2,
        );
}
