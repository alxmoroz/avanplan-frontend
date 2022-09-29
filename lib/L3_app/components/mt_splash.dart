// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'icons.dart';

class MTSplashScreen extends StatelessWidget {
  const MTSplashScreen({this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: (color ?? backgroundColor).resolve(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          gerculesIcon(),
          SizedBox(height: onePadding * 2),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
