// Copyright (c) 2021. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'mt_button.dart';

class MTCard extends StatelessWidget {
  const MTCard({this.body, this.title, this.margin, this.onTap, this.elevation, this.radius, this.padding});

  final Widget? title;
  final Widget? body;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final double? elevation;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final mainBgColor = darkBackgroundColor.resolve(context);
    final secondBgColor = darkBackgroundColor.resolve(context);
    final borderRadius = BorderRadius.circular(radius ?? onePadding / 2);
    return MTButton(
      '',
      onTap,
      child: Card(
        margin: margin ?? EdgeInsets.symmetric(horizontal: onePadding, vertical: onePadding / 2),
        elevation: elevation ?? 2,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        child: Container(
          clipBehavior: Clip.hardEdge,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            gradient: LinearGradient(
              transform: const GradientRotation(pi / 2),
              colors: [secondBgColor, mainBgColor],
            ),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            if (title != null) title!,
            if (body != null) body!,
          ]),
        ),
      ),
    );
  }
}
