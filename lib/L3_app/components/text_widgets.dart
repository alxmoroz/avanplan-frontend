// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../L2_data/services/platform.dart';
import 'colors.dart';

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
    this.height,
  });

  final String text;
  final double? sizeScale;
  final Color? color;
  final FontWeight? weight;
  final int? maxLines;
  final TextAlign? align;
  final EdgeInsets? padding;
  final TextDecoration? decoration;
  final double? height;

  TextStyle style(BuildContext context) {
    final cupertinoTS = CupertinoTheme.of(context).textTheme.textStyle;
    return cupertinoTS.copyWith(
      color: CupertinoDynamicColor.maybeResolve(color ?? darkGreyColor, context),
      fontWeight: weight ?? FontWeight.w400,
      fontSize: (cupertinoTS.fontSize ?? (isTablet ? 24 : 17)) * (sizeScale ?? 1),
      inherit: true,
      decoration: decoration,
      height: height ?? cupertinoTS.height,
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
        maxLines: maxLines ?? 1000,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class SmallText extends _BaseText {
  const SmallText(
    String text, {
    int? maxLines,
    super.color,
    super.align,
    super.padding,
    super.decoration,
  }) : super(
          text,
          sizeScale: 0.85,
          maxLines: maxLines ?? 9,
        );
}

class LightText extends _BaseText {
  const LightText(
    String text, {
    int? maxLines,
    double? height,
    super.sizeScale,
    super.color,
    super.align,
    super.padding,
    super.decoration,
  }) : super(
          text,
          weight: FontWeight.w300,
          maxLines: maxLines ?? 7,
          height: height,
        );
}

class NormalText extends _BaseText {
  const NormalText(
    String text, {
    int? maxLines,
    super.sizeScale,
    super.color,
    super.align,
    super.padding,
    super.decoration,
  }) : super(
          text,
          weight: FontWeight.w400,
          maxLines: maxLines ?? 7,
        );
}

class MediumText extends _BaseText {
  const MediumText(
    String text, {
    int? maxLines,
    super.sizeScale,
    super.color,
    super.align,
    super.padding,
    super.decoration,
  }) : super(
          text,
          weight: FontWeight.w500,
          maxLines: maxLines ?? 5,
        );
}

class H4 extends _BaseText {
  const H4(
    String text, {
    int? maxLines,
    super.color,
    super.align,
    super.padding,
    super.decoration,
  }) : super(
          text,
          weight: FontWeight.w400,
          sizeScale: 1.25,
          maxLines: maxLines ?? 3,
          height: 1.2,
        );
}

class H3 extends _BaseText {
  const H3(
    String text, {
    Color? color,
    int? maxLines,
    super.align,
    super.padding,
    super.decoration,
  }) : super(
          text,
          color: color ?? greyColor,
          weight: FontWeight.w400,
          sizeScale: 1.75,
          maxLines: maxLines ?? 3,
          height: 1.1,
        );
}

class H2 extends _BaseText {
  const H2(
    String text, {
    Color? color,
    int? maxLines,
    super.align,
    super.padding,
    super.decoration,
  }) : super(
          text,
          color: color ?? greyColor,
          weight: FontWeight.w300,
          sizeScale: 1.9,
          maxLines: maxLines ?? 3,
          height: 1.1,
        );
}

class H1 extends _BaseText {
  const H1(
    String text, {
    int? maxLines,
    super.color,
    super.align,
    super.padding,
    super.decoration,
  }) : super(
          text,
          weight: FontWeight.w300,
          sizeScale: 2.45,
          maxLines: maxLines ?? 2,
          height: 1,
        );
}

class D2 extends _BaseText {
  const D2(
    String text, {
    int? maxLines,
    super.color,
    super.align,
    super.padding,
    super.decoration,
  }) : super(
          text,
          weight: FontWeight.w500,
          sizeScale: 2.5,
          maxLines: maxLines ?? 1,
          height: 1,
        );
}

class D1 extends _BaseText {
  const D1(
    String text, {
    int? maxLines,
    super.color,
    super.align,
    super.padding,
    super.decoration,
  }) : super(
          text,
          weight: FontWeight.w500,
          sizeScale: 3,
          maxLines: maxLines ?? 1,
          height: 1,
        );
}
