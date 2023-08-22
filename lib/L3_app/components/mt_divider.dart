// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';

class MTDivider extends StatelessWidget {
  const MTDivider({this.color, this.height, this.indent, this.endIndent});

  final Color? color;
  final double? height;
  final double? indent;
  final double? endIndent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: (color ?? fgL4Color).resolve(context),
      thickness: 0.2,
      indent: indent ?? 0,
      endIndent: endIndent ?? 0,
      height: height ?? P,
    );
  }
}
