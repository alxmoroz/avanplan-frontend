// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'adaptive.dart';
import 'background.dart';
import 'constants.dart';
import 'scrollable.dart';

class MTPage extends StatelessWidget {
  const MTPage({
    super.key,
    this.appBar,
    required this.body,
    this.bottomBar,
    this.leftBar,
    this.rightBar,
    this.scrollController,
    this.scrollOffsetTop,
    this.onScrolled,
  });

  final PreferredSizeWidget? leftBar;
  final PreferredSizeWidget? rightBar;

  final PreferredSizeWidget? appBar;
  final Widget body;
  final PreferredSizeWidget? bottomBar;

  final ScrollController? scrollController;
  final double? scrollOffsetTop;
  final Function(bool)? onScrolled;

  Widget get _scaffold {
    return Builder(builder: (context) {
      final mq = MediaQuery.of(context);
      final mqPadding = mq.padding;
      final pTop = max(mqPadding.top, P3);
      final hasKB = mq.viewInsets.bottom > 0;
      final pBottom = max(mqPadding.bottom, P3);

      return MTBackgroundWrapper(
        PrimaryScrollController(
          controller: scrollController ?? ScrollController(),
          child: MediaQuery(
            data: mq.copyWith(
              padding: mqPadding.copyWith(
                top: pTop,
                bottom: pBottom,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              key: key,
              appBar: appBar,
              body: MediaQuery(
                  data: mq.copyWith(
                    padding: mqPadding.copyWith(
                      top: pTop + (appBar?.preferredSize ?? Size.zero).height,
                      bottom: pBottom + (hasKB ? 0 : (bottomBar?.preferredSize ?? Size.zero).height),
                    ),
                  ),
                  child: scrollOffsetTop != null && scrollController != null
                      ? MTScrollable(
                          scrollController: scrollController!,
                          scrollOffsetTop: scrollOffsetTop!,
                          onScrolled: onScrolled,
                          bottomShadow: bottomBar != null,
                          child: isBigScreen(context) ? Padding(padding: EdgeInsets.only(top: scrollOffsetTop!), child: body) : body,
                        )
                      : body),
              extendBody: true,
              extendBodyBehindAppBar: true,
              bottomNavigationBar: bottomBar,
            ),
          ),
        ),
      );
    });
  }

  double get _leftBarWidth => (leftBar?.preferredSize ?? Size.zero).width;
  double get _rightBarWidth => (rightBar?.preferredSize ?? Size.zero).width;

  bool get _hasLeftBar => leftBar != null;
  bool get _hasRightBar => rightBar != null;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final mqPadding = mq.padding;
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Stack(
        children: [
          _hasLeftBar || _hasRightBar
              ? Observer(
                  builder: (_) => MediaQuery(
                    data: mq.copyWith(
                      padding: mqPadding.copyWith(
                        left: mqPadding.left + _leftBarWidth,
                        right: mqPadding.right + _rightBarWidth,
                      ),
                    ),
                    child: _scaffold,
                  ),
                )
              : _scaffold,
          if (_hasLeftBar) leftBar!,
          if (_hasRightBar) Align(alignment: Alignment.centerRight, child: rightBar!)
        ],
      ),
    );
  }
}
