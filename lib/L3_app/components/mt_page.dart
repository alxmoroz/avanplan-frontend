// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'mt_splash.dart';
import 'mt_toolbar.dart';

class MTPage extends StatelessWidget {
  const MTPage({
    required this.body,
    this.navBar,
    this.bottomBar,
    this.isLoading = false,
  });

  final CupertinoNavigationBar? navBar;
  final Widget body;
  final Widget? bottomBar;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CupertinoPageScaffold(
        navigationBar: navBar,
        child: Scaffold(
          body: body,
          resizeToAvoidBottomInset: false,
          backgroundColor: backgroundColor.resolve(context),
          extendBody: bottomBar != null,
          extendBodyBehindAppBar: bottomBar != null,
          bottomNavigationBar: bottomBar != null ? MTToolbar(child: bottomBar!) : null,
        ),
      ),
      if (isLoading) MTSplashScreen(color: loaderBgColor.resolve(context)),
    ]);
  }
}
