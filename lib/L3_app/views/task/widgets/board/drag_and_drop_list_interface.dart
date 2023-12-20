import 'package:flutter/material.dart';

import 'drag_and_drop_builder_parameters.dart';
import 'drag_and_drop_interface.dart';
import 'drag_and_drop_item.dart';

abstract class DragAndDropListInterface implements DragAndDropInterface {
  List<DragAndDropItem>? get children;

  bool get canDrag;

  Widget generateWidget(DragAndDropBuilderParameters params);
}

abstract class DragAndDropListExpansionInterface implements DragAndDropListInterface {
  DragAndDropListExpansionInterface({this.children});
  @override
  final List<DragAndDropItem>? children;

  bool get isExpanded;

  void toggleExpanded();

  void expand();

  void collapse();
}
