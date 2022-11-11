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
    this.drawer,
    super.key,
  });

  final CupertinoNavigationBar? navBar;
  final Widget body;
  final Widget? bottomBar;
  final Widget? drawer;

  @override
  Widget build(BuildContext context) => Scaffold(
        key: key,
        appBar: navBar,
        body: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: body,
        ),
        drawer: drawer,
        backgroundColor: backgroundColor.resolve(context),
        extendBody: bottomBar != null,
        extendBodyBehindAppBar: bottomBar != null,
        bottomNavigationBar: bottomBar != null ? MTToolbar(child: bottomBar!) : null,
      );
}
