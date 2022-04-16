// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'bottom_safe_padding.dart';
import 'colors.dart';
import 'material_wrapper.dart';

class MTCupertinoPage extends StatelessWidget {
  const MTCupertinoPage({
    required this.body,
    this.navBar,
    this.bgColor,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  final CupertinoNavigationBar? navBar;
  final Widget body;
  final MainAxisAlignment mainAxisAlignment;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: bgColor ?? backgroundColor,
      navigationBar: navBar,
      child: SafeArea(
        child: material(
          Column(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              body,
              BottomSafePadding(context),
            ],
          ),
        ),
      ),
    );
  }
}
