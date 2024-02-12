// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../presenters/number.dart';
import 'adaptive.dart';
import 'text.dart';

class MTPrice extends StatelessWidget {
  const MTPrice(this.value, {super.key, this.color, this.size = AdaptiveSize.m});

  final num value;
  final Color? color;
  final AdaptiveSize size;

  String get _text => '${value.currency}₽';

  @override
  Widget build(BuildContext context) {
    return {
          AdaptiveSize.xxs: D5(_text, color: color),
          AdaptiveSize.xs: D4(_text, color: color),
          AdaptiveSize.s: D3(_text, color: color),
          AdaptiveSize.m: D2(_text, color: color),
        }[size] ??
        D2(_text, color: color);
  }
}
