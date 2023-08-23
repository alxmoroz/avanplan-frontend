// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';

class MTCard extends StatelessWidget {
  const MTCard({
    required this.child,
    this.margin,
    this.elevation,
    this.radius,
    this.padding,
    this.borderSide,
    this.color,
    this.shadowColor,
  });

  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? elevation;
  final double? radius;
  final BorderSide? borderSide;
  final Color? color;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    final borderRadius = radius ?? DEF_BORDER_RADIUS;
    final _color = (color ?? b3Color).resolve(context);
    final _shadowColor = (shadowColor ?? f2Color).resolve(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: margin ?? EdgeInsets.zero,
      elevation: elevation ?? cardElevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius), side: borderSide ?? BorderSide.none),
      child: Padding(child: child, padding: padding ?? EdgeInsets.zero),
      surfaceTintColor: _color,
      color: _color,
      shadowColor: _shadowColor,
    );
  }
}
