// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';

class MTRoundedContainer extends StatelessWidget {
  const MTRoundedContainer({required this.child, this.padding, this.borderRadius, this.color, this.border});

  final Widget child;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Color? color;
  final Border? border;

  @override
  Widget build(BuildContext context) => Container(
        clipBehavior: Clip.hardEdge,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? defaultBorderRadius),
          color: color != null ? color!.resolve(context) : null,
          border: border,
        ),
        child: child,
      );
}
