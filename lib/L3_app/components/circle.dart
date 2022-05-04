// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';

class CircleWidget extends StatelessWidget {
  const CircleWidget({this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? onePadding,
      height: size ?? onePadding,
      decoration: BoxDecoration(
        color: (color ?? darkGreyColor).resolve(context),
        shape: BoxShape.circle,
      ),
    );
  }
}
