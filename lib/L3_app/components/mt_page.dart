// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'material_wrapper.dart';
import 'splash.dart';

class MTPage extends StatelessWidget {
  const MTPage({
    required this.body,
    this.navBar,
    this.isLoading = false,
  });

  final CupertinoNavigationBar? navBar;
  final Widget body;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CupertinoPageScaffold(
        navigationBar: navBar,
        child: material(body),
      ),
      if (isLoading) SplashScreen(color: loaderColor.resolve(context)),
    ]);
  }
}
