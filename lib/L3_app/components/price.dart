// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../components/colors_base.dart';
import '../presenters/number.dart';
import 'adaptive.dart';
import 'constants.dart';
import 'text.dart';

class MTPrice extends StatelessWidget {
  const MTPrice(
    this.value, {
    super.key,
    this.color,
    this.finalValue,
    this.rowAlign = MainAxisAlignment.center,
    this.size = AdaptiveSize.m,
  });

  final num value;
  final num? finalValue;
  final Color? color;
  final AdaptiveSize size;
  final MainAxisAlignment rowAlign;

  Widget get _finalPrice {
    final text = '${(finalValue ?? value).currency}₽';
    return {
          AdaptiveSize.xs: DSmallText(text, color: color),
          AdaptiveSize.s: D3(text, color: color),
          AdaptiveSize.m: D2(text, color: color),
        }[size] ??
        D2(text, color: color);
  }

  Widget get _originalPrice {
    final text = '${value.currency}₽';
    const decoration = TextDecoration.lineThrough;
    return Padding(
      padding: const EdgeInsets.only(left: P, bottom: P_2),
      child: {
            AdaptiveSize.m: D3(text, color: f2Color, decoration: decoration),
          }[size] ??
          DSmallText(text, color: f2Color, decoration: decoration),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: rowAlign,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _finalPrice,
        if (finalValue != null) _originalPrice,
      ],
    );
  }
}
