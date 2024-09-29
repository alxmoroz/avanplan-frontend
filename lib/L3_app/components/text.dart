// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors_base.dart';

class BaseText extends StatelessWidget {
  const BaseText(
    this.text, {
    super.key,
    this.sizeScale,
    this.color,
    this.weight,
    this.maxLines,
    this.align,
    this.padding,
    this.height,
    this.decoration,
  });

  const BaseText.f2(
    this.text, {
    super.key,
    this.sizeScale,
    this.weight,
    this.maxLines,
    this.align,
    this.padding,
    this.height,
    this.decoration,
  }) : color = f2Color;

  const BaseText.f3(
    this.text, {
    super.key,
    this.sizeScale,
    this.weight,
    this.maxLines,
    this.align,
    this.padding,
    this.height,
    this.decoration,
  }) : color = f3Color;

  const BaseText.medium(
    this.text, {
    super.key,
    this.sizeScale,
    this.maxLines,
    this.align,
    this.padding,
    this.height,
    this.color,
    this.decoration,
  }) : weight = FontWeight.w500;

  final String text;
  final double? sizeScale;
  final Color? color;
  final FontWeight? weight;
  final int? maxLines;
  final TextAlign? align;
  final EdgeInsets? padding;
  final double? height;
  final TextDecoration? decoration;

  TextStyle style(BuildContext context) {
    final cupertinoTS = CupertinoTheme.of(context).textTheme.textStyle;
    // если указан явно межстрочный интервал, то оставляем его.
    // Если указано количество строк, то для однострочников - 1, для двух - 1.1, для трех - 1.2, для остального всего - 1.3
    final double h = height ?? {1: 1.0, 2: 1.1, 3: 1.2}[maxLines] ?? 1.3;
    final double fs = 17 * (sizeScale ?? 1);
    final rColor = CupertinoDynamicColor.maybeResolve(color ?? f1Color, context);

    return cupertinoTS.copyWith(
      fontFamily: 'RobotoAvanplan',
      color: rColor,
      decorationColor: rColor,
      fontWeight: weight ?? FontWeight.w400,
      fontSize: fs,
      height: h,
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
        maxLines: maxLines ?? 1000,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class SmallText extends BaseText {
  const SmallText(
    super.text, {
    super.key,
    int? maxLines,
    super.height,
    Color? color,
    super.align,
    super.padding,
    super.weight,
  }) : super(
          color: color ?? f2Color,
          sizeScale: 0.85,
          maxLines: maxLines ?? 9,
        );
}

class H3 extends BaseText {
  const H3(
    super.text, {
    super.key,
    int? maxLines,
    double? height,
    super.color,
    super.align,
    super.padding,
  }) : super(
          sizeScale: 1.22,
          maxLines: maxLines ?? 5,
          height: height ?? 1.2,
        );
}

class H2 extends BaseText {
  const H2(
    super.text, {
    super.key,
    super.color,
    int? maxLines,
    double? height,
    super.align,
    super.padding,
  }) : super(
          sizeScale: 1.42,
          maxLines: maxLines ?? 3,
          height: height ?? 1.1,
        );
}

class H1 extends BaseText {
  const H1(
    super.text, {
    super.key,
    super.color,
    int? maxLines,
    double? height,
    super.align,
    super.padding,
  }) : super(
          weight: FontWeight.w300,
          sizeScale: 1.65,
          maxLines: maxLines ?? 2,
          height: height ?? 1.1,
        );
}

/// Цифры
class DText extends BaseText {
  const DText(
    super.text, {
    super.key,
    super.color,
    super.sizeScale = 1.15,
    super.padding,
    super.decoration,
    super.maxLines = 1,
    super.align = TextAlign.center,
    super.weight = FontWeight.w400,
  });

  const DText.medium(
    super.text, {
    super.key,
    super.color,
    super.sizeScale = 1.15,
    super.padding,
    super.decoration,
    super.maxLines = 1,
    super.align = TextAlign.center,
    super.weight = FontWeight.w500,
  });

  const DText.bold(
    super.text, {
    super.key,
    super.color,
    super.sizeScale = 1.15,
    super.padding,
    super.decoration,
    super.maxLines = 1,
    super.align = TextAlign.center,
    super.weight = FontWeight.w700,
  });

  @override
  TextStyle style(BuildContext context) => super.style(context).copyWith(fontFamily: 'MontserratAvanplan');
}

class DSmallText extends DText {
  const DSmallText(super.text, {super.key, super.color, super.padding, super.maxLines, super.align, super.weight, super.decoration})
      : super(sizeScale: 0.95);
  const DSmallText.bold(super.text, {super.key, super.color, super.padding, super.align}) : super.bold(sizeScale: 0.95);
}

class D3 extends DText {
  const D3(super.text, {super.key, super.color, super.padding, super.maxLines, super.align, super.weight, super.decoration}) : super(sizeScale: 1.5);
  const D3.medium(super.text, {super.key, super.color, super.padding, super.align, super.decoration}) : super.medium(sizeScale: 1.5);
  const D3.bold(super.text, {super.key, super.color, super.padding, super.align, super.decoration}) : super.bold(sizeScale: 1.5);
}

class D2 extends DText {
  const D2(super.text, {super.key, super.color, super.padding, super.maxLines, super.align, super.decoration}) : super.medium(sizeScale: 2.3);
}

/// Декоративный стиль (для названия приложения)
abstract class _BaseDecorText extends BaseText {
  const _BaseDecorText(
    super.text, {
    super.key,
    super.color,
    super.padding,
    FontWeight? weight,
  }) : super(align: TextAlign.center, weight: weight ?? FontWeight.w600, maxLines: 1);

  @override
  TextStyle style(BuildContext context) => super.style(context).copyWith(fontFamily: 'ComfortaaAvanplan', fontSize: 26);
}

// название приложения
class DecorAppTitle extends _BaseDecorText {
  const DecorAppTitle(super.text, {super.key, super.color, super.padding});
}
