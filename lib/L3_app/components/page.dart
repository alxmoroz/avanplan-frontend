// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'toolbar.dart';

class MTPage extends StatelessWidget {
  const MTPage({
    required this.body,
    this.appBar,
    this.bottomBar,
    super.key,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomBar;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          key: key,
          appBar: appBar,
          body: body,
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: bottomBar != null ? MTToolbar(child: bottomBar!, color: navbarDefaultBgColor) : null,
        ),
      );
}
