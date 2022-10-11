// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'mt_rounded_container.dart';

class MTCard extends StatelessWidget {
  const MTCard({required this.child, this.margin, this.onTap, this.elevation, this.radius, this.padding, this.color});

  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final double? elevation;
  final double? radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final borderRadius = radius ?? defaultBorderRadius;
    final _color = (color ?? darkBackgroundColor).resolve(context);
    return CupertinoButton(
      minSize: 0,
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Card(
        margin: margin ?? EdgeInsets.symmetric(horizontal: onePadding, vertical: onePadding / 2),
        elevation: elevation ?? 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        child: MTRoundedContainer(borderRadius: borderRadius, child: child, padding: padding ?? EdgeInsets.all(onePadding), color: _color),
      ),
    );
  }
}
