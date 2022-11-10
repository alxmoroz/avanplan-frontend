// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';

class MTCircle extends StatelessWidget {
  const MTCircle({this.color, this.size, this.border});

  final Color? color;
  final double? size;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? P,
      height: size ?? P,
      decoration: BoxDecoration(
        color: (color ?? darkGreyColor).resolve(context),
        shape: BoxShape.circle,
        border: border ?? const Border(),
      ),
    );
  }
}
