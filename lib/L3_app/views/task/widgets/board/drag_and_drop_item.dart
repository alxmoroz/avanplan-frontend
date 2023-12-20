import 'package:flutter/widgets.dart';

import 'drag_and_drop_interface.dart';

class DragAndDropItem implements DragAndDropInterface {
  DragAndDropItem({
    required this.child,
    this.feedbackWidget,
    this.canDrag = true,
  });

  final Widget child;
  final Widget? feedbackWidget;
  final bool canDrag;
}
