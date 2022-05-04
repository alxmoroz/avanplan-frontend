// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (color ?? backgroundColor).resolve(context),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
