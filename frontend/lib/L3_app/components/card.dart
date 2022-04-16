// Copyright (c) 2021. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';

class MTCard extends StatelessWidget {
  const MTCard({this.body, this.title, this.margin, this.onTap});

  final Widget? title;
  final Widget? body;
  final EdgeInsets? margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const double radius = 8;
    final mainBgColor = darkBackgroundColor.resolve(context);
    final secondBgColor = darkBackgroundColor.resolve(context);
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: margin ?? EdgeInsets.symmetric(horizontal: onePadding, vertical: onePadding / 2),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: LinearGradient(
              transform: const GradientRotation(pi / 2),
              colors: [secondBgColor, mainBgColor],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (title != null) title!,
              if (body != null) body!,
            ],
          ),
        ),
      ),
    );
  }
}
