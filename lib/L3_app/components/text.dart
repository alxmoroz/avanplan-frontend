// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../L2_data/services/platform.dart';
import 'colors_base.dart';

class BaseText extends StatelessWidget {
  const BaseText(
    this.text, {
    this.sizeScale,
    this.color,
    this.weight,
    this.maxLines,
    this.align,
    this.padding,
    this.height,
  });

  const BaseText.f2(
    this.text, {
    this.sizeScale,
    this.weight,
    this.maxLines,
    this.align,
    this.padding,
    this.height,
  }) : color = f2Color;

  const BaseText.f3(
    this.text, {
    this.sizeScale,
    this.weight,
    this.maxLines,
    this.align,
    this.padding,
    this.height,
  }) : color = f3Color;

  const BaseText.light(
    this.text, {
    this.sizeScale,
    this.maxLines,
    this.align,
    this.padding,
    this.height,
    this.color,
  }) : weight = FontWeight.w300;

  const BaseText.medium(
    this.text, {
    this.sizeScale,
    this.maxLines,
    this.align,
    this.padding,
    this.height,
    this.color,
  }) : weight = FontWeight.w500;

  final String text;
  final double? sizeScale;
  final Color? color;
  final FontWeight? weight;
  final int? maxLines;
  final TextAlign? align;
  final EdgeInsets? padding;
  final double? height;

  TextStyle style(BuildContext context) {
    final cupertinoTS = CupertinoTheme.of(context).textTheme.textStyle;
    return cupertinoTS.copyWith(
      color: CupertinoDynamicColor.maybeResolve(color ?? f1Color, context),
      fontWeight: weight ?? FontWeight.w400,
      fontSize: (cupertinoTS.fontSize ?? (isTablet ? 24 : 16)) * (sizeScale ?? 1),
      inherit: true,
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

class SmallText extends BaseText {
  const SmallText(
    String text, {
    int? maxLines,
    double? height,
    Color? color,
    super.align,
    super.padding,
  }) : super(
          text,
          color: color ?? f2Color,
          sizeScale: 0.9,
          maxLines: maxLines ?? 9,
          height: height,
        );
}

class H3 extends BaseText {
  const H3(
    String text, {
    int? maxLines,
    super.color,
    super.align,
    super.padding,
  }) : super(
          text,
          sizeScale: 1.25,
          maxLines: maxLines ?? 5,
          height: 1.2,
        );
}

class H2 extends BaseText {
  const H2(
    String text, {
    Color? color,
    int? maxLines,
    super.align,
    super.padding,
  }) : super(
          text,
          color: color,
          sizeScale: 1.55,
          maxLines: maxLines ?? 3,
          height: 1.1,
        );
}

class H1 extends BaseText {
  const H1(
    String text, {
    Color? color,
    int? maxLines,
    super.align,
    super.padding,
  }) : super(
          text,
          color: color,
          weight: FontWeight.w300,
          sizeScale: 1.8,
          maxLines: maxLines ?? 2,
          height: 1.1,
        );
}

/// Цифры
abstract class _BaseDText extends BaseText {
  const _BaseDText(
    super.text, {
    super.color,
    super.sizeScale,
    FontWeight? weight,
  }) : super(align: TextAlign.center, weight: weight ?? FontWeight.w500, height: 1);

  const _BaseDText.bold(
    super.text, {
    super.color,
    super.sizeScale,
  }) : super(align: TextAlign.center, weight: FontWeight.w700, height: 1);

  @override
  TextStyle style(BuildContext context) => super.style(context).copyWith(fontFamily: 'Montserrat');
}

class D6 extends _BaseDText {
  const D6(String text, {super.color}) : super.bold(text, sizeScale: 0.9);
}

class D5 extends _BaseDText {
  const D5(String text, {super.color}) : super(text, sizeScale: 1.15);
}

class D4 extends _BaseDText {
  const D4(String text, {super.color}) : super(text, sizeScale: 1.55);
}

class D3 extends _BaseDText {
  const D3(String text, {super.color}) : super(text, sizeScale: 2.5);
}

class D2 extends _BaseDText {
  const D2(String text, {super.color}) : super(text, sizeScale: 3.2);
}

class D1 extends _BaseDText {
  const D1(String text, {super.color}) : super(text, sizeScale: 9);
}

/// Декоративный стиль
abstract class _BaseDecorText extends BaseText {
  const _BaseDecorText(
    super.text, {
    super.color,
    super.sizeScale,
    super.padding,
    FontWeight? weight,
  }) : super(align: TextAlign.center, weight: weight ?? FontWeight.w600, height: 1);

  @override
  TextStyle style(BuildContext context) => super.style(context).copyWith(fontFamily: 'Comfortaa');
}

// название приложения
class DecorAppTitle extends _BaseDecorText {
  const DecorAppTitle(String text, {super.color, super.padding}) : super(text, sizeScale: 1.64);
}
