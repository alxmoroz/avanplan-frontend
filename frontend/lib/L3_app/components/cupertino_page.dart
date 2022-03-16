// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'bottom_safe_padding.dart';
import 'colors.dart';
import 'material_wrapper.dart';

class MTCupertinoPage extends StatelessWidget {
  const MTCupertinoPage({
    this.navBar,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
  });

  final CupertinoNavigationBar? navBar;
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: true,
      navigationBar: navBar,
      child: SafeArea(
        child: material(
          Column(
            crossAxisAlignment: crossAxisAlignment,
            mainAxisAlignment: mainAxisAlignment,
            children: [
              ...children,
              BottomSafePadding(context),
            ],
          ),
        ),
      ),
    );
  }
}
