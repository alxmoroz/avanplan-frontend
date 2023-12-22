// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'background.dart';

class MTPage extends StatelessWidget {
  const MTPage({
    this.scrollController,
    required this.body,
    this.appBar,
    this.bottomBar,
    this.rightBar,
  });

  final ScrollController? scrollController;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomBar;
  final Widget? rightBar;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Row(
          children: [
            Expanded(
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
            ),
            if (rightBar != null) rightBar!
          ],
        ),
      );
}
