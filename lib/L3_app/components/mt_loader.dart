// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';

class MTLoader extends StatelessWidget {
  const MTLoader({this.radius});
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: backgroundColor.resolve(context).withAlpha(170),
              borderRadius: BorderRadius.circular(radius ?? 0),
            ),
          ),
          CircularProgressIndicator(color: mainColor.resolve(context)),
        ],
      ),
    );
  }
}
