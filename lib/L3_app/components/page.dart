// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'colors_base.dart';

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
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              // stops: const [0.2, 0.8],
              colors: [
                b2Color.resolve(context),
                b2TintColor.resolve(context),
              ],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            key: key,
            appBar: appBar,
            body: body,
            extendBody: true,
            extendBodyBehindAppBar: true,
            bottomNavigationBar: bottomBar,
          ),
        ),
      );
}
