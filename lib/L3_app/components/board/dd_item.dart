import 'package:flutter/widgets.dart';

class MTDragNDropItem {
  MTDragNDropItem({
    required this.child,
    this.feedbackWidget,
    this.canDrag = true,
  });

  final Widget child;
  final Widget? feedbackWidget;
  final bool canDrag;
}
