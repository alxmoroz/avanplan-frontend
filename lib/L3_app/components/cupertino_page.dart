// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'material_wrapper.dart';

class MTCupertinoPage extends StatelessWidget {
  const MTCupertinoPage({
    required this.body,
    this.navBar,
    this.bgColor,
  });

  final CupertinoNavigationBar? navBar;
  final Widget body;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: bgColor ?? backgroundColor,
      navigationBar: navBar,
      child: material(body),
    );
  }
}
