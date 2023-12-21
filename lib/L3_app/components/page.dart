// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'background.dart';

class MTPage extends StatelessWidget {
  const MTPage({
    required this.body,
    this.appBar,
    this.bottomBar,
    this.scrollController,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomBar;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: MTBackgroundWrapper(
          Scaffold(
            backgroundColor: Colors.transparent,
            key: key,
            appBar: appBar,
            body: PrimaryScrollController(
              controller: scrollController ?? ScrollController(),
              child: body,
            ),
            extendBody: true,
            extendBodyBehindAppBar: true,
            bottomNavigationBar: bottomBar,
          ),
        ),
      );
}
