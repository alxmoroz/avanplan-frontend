// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../presenters/number.dart';
import 'text.dart';

class MTBigPrice extends StatelessWidget {
  const MTBigPrice(this.value, {super.key, this.color});

  final num value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return D2('${value.currency}₽', color: color);
  }
}
