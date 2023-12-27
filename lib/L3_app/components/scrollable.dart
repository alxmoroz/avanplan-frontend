// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'constants.dart';
import 'shadowed.dart';

class MTScrollable extends StatefulWidget {
  const MTScrollable({required this.child, this.scrollOffsetTop, this.onScrolled});
  final double? scrollOffsetTop;
  final Widget child;
  final Function(bool)? onScrolled;

  @override
  _MTScrollableState createState() => _MTScrollableState();
}

class _MTScrollableState extends State<MTScrollable> {
  late final ScrollController _scrollController;
  bool _hasScrolled = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    final offset = widget.scrollOffsetTop ?? 0 + P8;
    _scrollController.addListener(() {
      if ((!_hasScrolled && _scrollController.offset > offset) || (_hasScrolled && _scrollController.offset < offset)) {
        setState(() {
          _hasScrolled = !_hasScrolled;
          if (widget.onScrolled != null) {
            widget.onScrolled!(_hasScrolled);
          }
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final mqPadding = mq.padding;
    return MediaQuery(
      data: mq.copyWith(
        padding: mqPadding.copyWith(
          // top: mq.padding.top + (_hasScrolled ? 0 : (widget.scrollOffsetTop ?? 0)),
          // top: mq.padding.top + (isBigScreen ? widget.scrollOffsetTop ?? 0 : 0),
          top: mq.padding.top,
        ),
      ),
      child: MTShadowed(
        topShadow: _hasScrolled,
        topPaddingIndent: P,
        child: PrimaryScrollController(controller: _scrollController, child: widget.child),
      ),
    );
  }
}
