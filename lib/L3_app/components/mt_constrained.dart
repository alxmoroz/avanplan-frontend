// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'constants.dart';

class MTConstrained extends StatelessWidget {
  const MTConstrained(this.child, {this.maxWidth});

  final Widget? child;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, size) => UnconstrainedBox(
        child: SizedBox(
          width: min(maxWidth ?? SCR_S_WIDTH, size.maxWidth),
          child: child,
        ),
      ),
    );
  }
}
