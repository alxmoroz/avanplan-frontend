// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'material_wrapper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoDynamicColor.resolve(color ?? CupertinoColors.systemBackground, context),
      child: material(
        const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
