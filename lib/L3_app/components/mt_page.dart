// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) => GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          key: key,
          appBar: navBar,
          body: body,
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: bottomBar != null ? MTToolbar(child: bottomBar!) : null,
        ),
      );
}
