// Copyright (c) 2021. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';

class AMCard extends StatelessWidget {
  const AMCard({this.body, this.title, this.margin});

  @protected
  final Widget? title;
  @protected
  final Widget? body;
  @protected
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    const double radius = 8;
    final mainBgColor = cardBackgroundColor.resolve(context);
    final secondBgColor = cardBackgroundColor.resolve(context);
    return Card(
      margin: margin ?? EdgeInsets.symmetric(horizontal: isTablet ? 50 : 12, vertical: isTablet ? 10 : 8),
      elevation: 6,
      color: mainBgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: LinearGradient(
            transform: const GradientRotation(pi / 2),
            colors: [
              secondBgColor,
              mainBgColor,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null) title!,
            if (body != null) body!,
          ],
        ),
      ),
    );
  }
}
