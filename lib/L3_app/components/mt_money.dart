// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'icons_workspace.dart';
import 'text_widgets.dart';

class MTCurrency extends StatelessWidget {
  const MTCurrency(this.value, this.color);

  final num value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        D1('$value', color: color),
        RoubleIcon(color: color),
      ],
    );
  }
}
