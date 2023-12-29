// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'constants.dart';
import 'shadowed.dart';

class MTScrollable extends StatefulWidget {
  const MTScrollable({required this.scrollController, required this.child, required this.scrollOffsetTop, this.onScrolled});
  final ScrollController scrollController;
  final double scrollOffsetTop;
  final Widget child;
  final Function(bool)? onScrolled;

  @override
  _MTScrollableState createState() => _MTScrollableState();
}

class _MTScrollableState extends State<MTScrollable> {
  bool _hasScrolled = false;

  @override
  void initState() {
    final offset = widget.scrollOffsetTop;
    widget.scrollController.addListener(() {
      if ((!_hasScrolled && widget.scrollController.offset > offset) || (_hasScrolled && widget.scrollController.offset < offset)) {
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
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final mqPadding = mq.padding;
    return MediaQuery(
      data: mq.copyWith(padding: mqPadding.copyWith(top: mq.padding.top)),
      child: MTShadowed(
        topShadow: _hasScrolled,
        topPaddingIndent: P,
        child: PrimaryScrollController(
          controller: widget.scrollController,
          child: widget.child,
        ),
      ),
    );
  }
}
