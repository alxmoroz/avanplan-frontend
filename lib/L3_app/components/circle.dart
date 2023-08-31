// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';

class MTCircle extends StatelessWidget {
  const MTCircle({this.color, this.size, this.border});

  final Color? color;
  final double? size;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? P2,
      height: size ?? P2,
      decoration: BoxDecoration(
        color: (color ?? f2Color).resolve(context),
        shape: BoxShape.circle,
        border: border ?? const Border(),
      ),
    );
  }
}
