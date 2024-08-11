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
    final scrolledOffset = widget.scrollController.offset;
    if ((!_hasScrolled && scrolledOffset > offset) || (_hasScrolled && scrolledOffset < offset)) {
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
    return MTShadowed(
      topShadow: _hasScrolled,
      bottomShadow: widget.bottomShadow,
      topPaddingIndent: P,
      child: PrimaryScrollController(
        controller: widget.scrollController,
        child: widget.child,
      ),
    );
  }
}
