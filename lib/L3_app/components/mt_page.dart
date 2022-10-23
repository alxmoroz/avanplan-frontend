// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'mt_toolbar.dart';

class MTPage extends StatelessWidget {
  const MTPage({
    required this.body,
    this.navBar,
    this.bottomBar,
  });

  final CupertinoNavigationBar? navBar;
  final Widget body;
  final Widget? bottomBar;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: navBar,
      child: Scaffold(
        body: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: body,
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor.resolve(context),
        extendBody: bottomBar != null,
        extendBodyBehindAppBar: bottomBar != null,
        bottomNavigationBar: bottomBar != null ? MTToolbar(child: bottomBar!) : null,
      ),
    );
  }
}
