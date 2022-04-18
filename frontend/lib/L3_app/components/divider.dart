// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';

class MTDivider extends StatelessWidget {
  const MTDivider({this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: (color ?? borderColor).resolve(context),
      thickness: 0.2,
    );
  }
}
