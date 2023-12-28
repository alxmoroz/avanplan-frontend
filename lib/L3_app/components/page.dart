// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'background.dart';
import 'scrollable.dart';

class MTPage extends StatelessWidget {
  const MTPage({
    this.appBar,
    required this.body,
    this.bottomBar,
    this.leftBar,
    this.rightBar,
    this.scrollController,
    this.scrollOffsetTop,
    this.onScrolled,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomBar;
  final PreferredSizeWidget? leftBar;
  final PreferredSizeWidget? rightBar;

  final ScrollController? scrollController;
  final double? scrollOffsetTop;
  final Function(bool)? onScrolled;

  Widget get _scaffold {
    return Builder(builder: (context) {
      final mq = MediaQuery.of(context);
      final mqPadding = mq.padding;
      return MTBackgroundWrapper(
        Scaffold(
          backgroundColor: Colors.transparent,
          key: key,
          appBar: appBar,
          body: scrollOffsetTop != null && scrollController != null
              ? MediaQuery(
                  data: mq.copyWith(
                    padding: mqPadding.copyWith(
                      top: mq.padding.top + (appBar?.preferredSize ?? Size.zero).height,
                    ),
                  ),
                  child: MTScrollable(
                    scrollController: scrollController!,
                    scrollOffsetTop: scrollOffsetTop!,
                    child: body,
                    onScrolled: onScrolled,
                  ),
                )
              : body,
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: bottomBar,
        ),
      );
    });
  }

  double get _leftBarWidth => (leftBar?.preferredSize ?? Size.zero).width;
  double get _rightBarWidth => (rightBar?.preferredSize ?? Size.zero).width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Stack(
        children: [
          _leftBarWidth > 0 || _rightBarWidth > 0
              ? Observer(builder: (_) {
                  final mq = MediaQuery.of(context);
                  final mqPadding = mq.padding;
                  return MediaQuery(
                    data: mq.copyWith(
                      padding: mqPadding.copyWith(
                        left: mqPadding.left + _leftBarWidth,
                        right: mqPadding.right + _rightBarWidth,
                      ),
                    ),
                    child: _scaffold,
                  );
                })
              : _scaffold,
          if (leftBar != null) leftBar!,
          if (rightBar != null) Align(alignment: Alignment.centerRight, child: rightBar!)
        ],
      ),
    );
  }
}
