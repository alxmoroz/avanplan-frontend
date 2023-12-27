// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'adaptive.dart';
import 'background.dart';
import 'scrollable.dart';

class MTPage extends StatefulWidget {
  const MTPage({
    this.scrollOffsetTop,
    this.appBar,
    required this.body,
    this.leftBar,
    this.bottomBar,
    this.rightBar,
  });

  final double? scrollOffsetTop;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final PreferredSizeWidget? leftBar;
  final PreferredSizeWidget? rightBar;
  final Widget? bottomBar;

  @override
  _MTPageState createState() => _MTPageState();
}

class _MTPageState extends State<MTPage> {
  bool _hasScrolled = false;

  Widget get _scaffold {
    return Builder(builder: (context) {
      final mq = MediaQuery.of(context);
      final mqPadding = mq.padding;
      return MTBackgroundWrapper(
        Scaffold(
          backgroundColor: Colors.transparent,
          key: widget.key,
          appBar: isBigScreen && widget.scrollOffsetTop != null && !_hasScrolled ? null : widget.appBar,
          body: widget.scrollOffsetTop != null
              ? MediaQuery(
                  data: mq.copyWith(
                    padding: mqPadding.copyWith(
                      top: mq.padding.top + (isBigScreen ? widget.scrollOffsetTop ?? 0 : 0),
                    ),
                  ),
                  child: MTScrollable(
                    scrollOffsetTop: widget.scrollOffsetTop,
                    child: widget.body,
                    onScrolled: (scrolled) => setState(() => _hasScrolled = scrolled),
                  ),
                )
              : widget.body,
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: widget.bottomBar,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Stack(
        children: [
          widget.leftBar != null || widget.rightBar != null
              ? Observer(builder: (_) {
                  final mq = MediaQuery.of(context);
                  final mqPadding = mq.padding;
                  return MediaQuery(
                    data: mq.copyWith(
                      padding: mqPadding.copyWith(
                        left: mqPadding.left + (widget.leftBar?.preferredSize ?? Size.zero).width,
                        right: mqPadding.right + (widget.rightBar?.preferredSize ?? Size.zero).width,
                      ),
                    ),
                    child: _scaffold,
                  );
                })
              : _scaffold,
          if (widget.leftBar != null) widget.leftBar!,
          if (widget.rightBar != null)
            Align(
              alignment: Alignment.centerRight,
              child: widget.rightBar!,
            )
        ],
      ),
    );
  }
}
