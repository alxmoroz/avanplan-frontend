// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../presenters/number.dart';
import 'adaptive.dart';
import 'text.dart';

class MTPrice extends StatelessWidget {
  const MTPrice(this.value, {super.key, this.color, this.align = TextAlign.center, this.size = AdaptiveSize.m});

  final num value;
  final Color? color;
  final AdaptiveSize size;
  final TextAlign? align;

  String get _text => '${value.currency}₽';

  @override
  Widget build(BuildContext context) {
    return {
          AdaptiveSize.xs: DSmallText(_text, color: color, align: align),
          AdaptiveSize.s: D3(_text, color: color, align: align),
          AdaptiveSize.m: D2(_text, color: color, align: align),
        }[size] ??
        D2(_text, color: color, align: align);
  }
}
