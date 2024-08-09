// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'constants.dart';
import 'shadowed.dart';

class MTScrollable extends StatefulWidget {
  const MTScrollable({
    super.key,
    required this.scrollController,
    required this.child,
    required this.scrollOffsetTop,
    this.onScrolled,
    this.bottomShadow = false,
  });
  final ScrollController scrollController;
  final double scrollOffsetTop;
  final Widget child;
  final bool bottomShadow;
  final Function(bool)? onScrolled;

  @override
  State<StatefulWidget> createState() => _MTScrollableState();
}

class _MTScrollableState extends State<MTScrollable> {
  bool _hasScrolled = false;

  void _listener() {
    final offset = widget.scrollOffsetTop;
    if ((!_hasScrolled && widget.scrollController.offset > offset) || (_hasScrolled && widget.scrollController.offset < offset)) {
      setState(() {
        _hasScrolled = !_hasScrolled;
        if (widget.onScrolled != null) {
          widget.onScrolled!(_hasScrolled);
        }
      });
    }
  }

  @override
  void initState() {
    widget.scrollController.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final mqPadding = mq.padding;
    return MediaQuery(
      data: mq.copyWith(padding: mqPadding.copyWith(top: mq.padding.top)),
      child: MTShadowed(
        topShadow: _hasScrolled,
        bottomShadow: widget.bottomShadow && mq.viewInsets.bottom == 0,
        topPaddingIndent: P,
        child: PrimaryScrollController(
          controller: widget.scrollController,
          child: widget.child,
        ),
      ),
    );
  }
}
