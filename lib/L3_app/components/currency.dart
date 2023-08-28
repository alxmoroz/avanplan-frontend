// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../presenters/number.dart';
import 'text.dart';

class MTCurrency extends StatelessWidget {
  const MTCurrency(this.value, {this.color});

  final num value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return D2('${value.currency}₽', color: color);
  }
}
