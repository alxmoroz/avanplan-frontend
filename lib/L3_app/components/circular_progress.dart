// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';

class MTCircularProgress extends StatelessWidget {
  const MTCircularProgress({this.size, this.color, this.strokeWidth, this.unbound = false});
  final double? size;
  final Color? color;
  final double? strokeWidth;
  final bool unbound;

  @override
  Widget build(BuildContext context) {
    final _size = size ?? P6;
    final ci = CircularProgressIndicator(
      color: color?.resolve(context),
      strokeWidth: strokeWidth ?? 4,
      strokeCap: StrokeCap.round,
    );
    return unbound
        ? ci
        : SizedBox(
            height: _size,
            width: _size,
            child: ci,
          );
  }
}
