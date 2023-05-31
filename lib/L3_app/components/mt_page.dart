// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'mt_toolbar.dart';

// TODO: оставить один MTPage без Scaffold => нужно сделать MTToolbar для верхней части

class MTPage extends StatelessWidget {
  const MTPage({
    required this.body,
    this.navBar,
    this.bottomBar,
    super.key,
  });

  final CupertinoNavigationBar? navBar;
  final Widget body;
  final Widget? bottomBar;

  @override
  Widget build(BuildContext context) => Scaffold(
        key: key,
        appBar: navBar,
        body: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: body,
        ),
        backgroundColor: backgroundColor.resolve(context),
        extendBody: true,
        extendBodyBehindAppBar: true,
        bottomNavigationBar: bottomBar != null ? MTToolbar(child: bottomBar!) : null,
      );
}

class MTPageSimple extends StatelessWidget {
  const MTPageSimple({
    required this.body,
    // this.topBar,
    this.bottomBar,
  });

  final Widget body;
  // final Widget? topBar;
  final Widget? bottomBar;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            color: backgroundColor.resolve(context),
            child: body,
          ),
          if (bottomBar != null) SizedBox(width: double.infinity, child: MTToolbar(child: bottomBar!)),
        ],
      ),
    );
  }
}
