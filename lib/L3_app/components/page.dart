// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'adaptive.dart';
import 'background.dart';
import 'constants.dart';
import 'shadowed.dart';

class MTPage extends StatefulWidget {
  const MTPage({
    this.scrollHeaderHeight,
    this.appBar,
    required this.body,
    this.leftBar,
    this.bottomBar,
    this.rightBar,
  });

  final double? scrollHeaderHeight;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final PreferredSizeWidget? leftBar;
  final PreferredSizeWidget? rightBar;
  final Widget? bottomBar;

  @override
  _MTPageState createState() => _MTPageState();
}

class _MTPageState extends State<MTPage> {
  late final ScrollController _scrollController;
  bool _hasScrolled = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    final offset = widget.scrollHeaderHeight ?? 0 + P8;
    _scrollController.addListener(() {
      if ((!_hasScrolled && _scrollController.offset > offset) || (_hasScrolled && _scrollController.offset < offset)) {
        setState(() => _hasScrolled = !_hasScrolled);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget get _scaffold {
    return Builder(builder: (context) {
      final mq = MediaQuery.of(context);
      final mqPadding = mq.padding;
      return MTBackgroundWrapper(
        Scaffold(
          backgroundColor: Colors.transparent,
          key: widget.key,
          appBar: isBigScreen && !_hasScrolled ? null : widget.appBar,
          body: PrimaryScrollController(
            controller: _scrollController,
            child: MediaQuery(
              data: mq.copyWith(
                padding: mqPadding.copyWith(
                  top: mq.padding.top + (isBigScreen ? widget.scrollHeaderHeight ?? 0 : 0),
                ),
              ),
              child: MTShadowed(topShadow: _hasScrolled, topPaddingIndent: P, child: widget.body),
            ),
          ),
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
