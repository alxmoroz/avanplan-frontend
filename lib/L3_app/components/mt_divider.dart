// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';

class MTDivider extends StatelessWidget {
  const MTDivider({this.color, this.height});

  final Color? color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: (color ?? greyColor).resolve(context),
      thickness: 0.2,
      height: height ?? P,
    );
  }
}
