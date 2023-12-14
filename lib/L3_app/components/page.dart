// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'colors_base.dart';
import 'images.dart';

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
            color: b2Color.resolve(context),
            image: DecorationImage(
              image: mtAssetImage(context, 'background'),
              repeat: ImageRepeat.repeatY,
              fit: BoxFit.fitWidth,
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
