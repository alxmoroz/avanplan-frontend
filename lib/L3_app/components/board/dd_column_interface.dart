// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import 'dd_item.dart';
import 'dd_parameters.dart';

abstract class MTDragNDropColumnInterface {
  List<MTDragNDropItem>? get children;

  bool get canDrag;

  Widget generateWidget(MTDragNDropParameters params);
}

abstract class MTDragNDropColumnExpansionInterface implements MTDragNDropColumnInterface {
  MTDragNDropColumnExpansionInterface({this.children});
  @override
  final List<MTDragNDropItem>? children;

  bool get isExpanded;

  void toggleExpanded();

  void expand();

  void collapse();
}
