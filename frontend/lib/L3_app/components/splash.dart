// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'material_wrapper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (color ?? backgroundColor).resolve(context),
      child: material(
        const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
