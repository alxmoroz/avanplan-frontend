// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'background.dart';

class MTPage extends StatelessWidget {
  const MTPage({
    this.scrollController,
    this.appBar,
    required this.body,
    this.leftBar,
    this.bottomBar,
    this.rightBar,
  });

  final ScrollController? scrollController;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final PreferredSizeWidget? leftBar;
  final PreferredSizeWidget? rightBar;
  final Widget? bottomBar;

  Widget get _body => MTBackgroundWrapper(
        Scaffold(
          backgroundColor: Colors.transparent,
          key: key,
          appBar: appBar,
          body: PrimaryScrollController(controller: scrollController!, child: body),
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: bottomBar,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final mqPadding = mq.padding;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Stack(
        children: [
          leftBar != null || rightBar != null
              ? Observer(
                  builder: (_) => MediaQuery(
                    data: mq.copyWith(
                      padding: mqPadding.copyWith(
                        left: mqPadding.left + (leftBar?.preferredSize ?? Size.zero).width,
                        right: mqPadding.right + (rightBar?.preferredSize ?? Size.zero).width,
                      ),
                    ),
                    child: _body,
                  ),
                )
              : _body,
          if (leftBar != null) leftBar!,
          if (rightBar != null)
            Align(
              alignment: Alignment.centerRight,
              child: rightBar!,
            )
        ],
      ),
    );
  }
}
