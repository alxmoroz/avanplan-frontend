// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
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
    final _color = (color ?? lightBackgroundColor).resolve(context);
    final _shadowColor = (shadowColor ?? lightGreyColor).resolve(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: margin ?? EdgeInsets.zero,
      elevation: elevation ?? 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius), side: borderSide ?? BorderSide.none),
      child: Padding(child: child, padding: padding ?? EdgeInsets.zero),
      surfaceTintColor: _color,
      color: _color,
      shadowColor: _shadowColor,
    );
  }
}

class MTCardButton extends StatelessWidget {
  const MTCardButton({required this.child, this.margin, this.onTap, required this.elevation, this.radius, this.padding, this.color});

  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final double elevation;
  final double? radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0,
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: MTCard(
        child: child,
        margin: margin ?? const EdgeInsets.symmetric(horizontal: P, vertical: P_2),
        elevation: elevation,
        radius: radius,
        padding: padding ?? const EdgeInsets.all(P),
        color: color,
      ),
    );
  }
}
