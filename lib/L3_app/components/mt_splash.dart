// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:gercules/L3_app/components/constants.dart';
import 'package:gercules/L3_app/components/icons.dart';

import 'colors.dart';

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
