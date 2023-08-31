// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'colors_base.dart';

class MTDivider extends StatelessWidget {
  const MTDivider({this.color, this.height, this.indent, this.endIndent});

  final Color? color;
  final double? height;
  final double? indent;
  final double? endIndent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: (color ?? b2Color).resolve(context),
      indent: indent ?? 0,
      endIndent: endIndent ?? 0,
      height: height ?? 1,
    );
  }
}
