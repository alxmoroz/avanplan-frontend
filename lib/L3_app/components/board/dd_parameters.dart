// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/widgets.dart';

import 'board.dart';
import 'dd_column_interface.dart';
import 'dd_item.dart';
import 'dd_item_target.dart';

typedef _OnPointerMove = void Function(PointerMoveEvent event);
typedef _OnPointerUp = void Function(PointerUpEvent event);
typedef _OnPointerDown = void Function(PointerDownEvent event);
typedef _OnItemReordered = void Function(
  MTDragNDropItem reorderedItem,
  MTDragNDropItem receiverItem,
);
typedef OnItemDropOnLastTarget = void Function(
  MTDragNDropItem newOrReorderedItem,
  MTDragNDropColumnInterface parentColumn,
  MTDragNDropItemTarget receiver,
);
typedef _OnColumnReordered = void Function(
  MTDragNDropColumnInterface reorderedColumn,
  MTDragNDropColumnInterface receiverColumn,
);

enum MTDragHandleVerticalAlignment {
  top,
  center,
  bottom,
}

class MTDragHandle extends StatelessWidget {
  const MTDragHandle({
    Key? key,
    required this.child,
    this.onLeft = false,
    this.verticalAlignment = MTDragHandleVerticalAlignment.center,
  }) : super(key: key);

  final bool onLeft;
  final MTDragHandleVerticalAlignment verticalAlignment;
  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}

class MTDragNDropParameters {
  MTDragNDropParameters({
    this.onPointerMove,
    this.onPointerUp,
    this.onPointerDown,
    this.onItemReordered,
    this.onItemDropOnLastTarget,
    this.onColumnReordered,
    this.columnDraggingWidth,
    this.columnOnWillAccept,
    this.columnTargetOnWillAccept,
    this.onColumnDraggingChanged,
    this.itemOnWillAccept,
    this.itemTargetOnWillAccept,
    this.onItemDraggingChanged,
    this.dragOnLongPress = true,
    this.verticalAlignment = CrossAxisAlignment.start,
    this.itemSizeAnimationDuration = 150,
    this.itemGhostOpacity = 0.3,
    this.itemGhost,
    this.itemDivider,
    this.itemDraggingWidth,
    this.itemDecorationWhileDragging,
    this.columnSizeAnimationDuration = 150,
    this.columnGhostOpacity = 0.3,
    this.columnGhost,
    this.columnPadding,
    this.columnDecoration,
    this.columnDecorationWhileDragging,
    this.columnWidth = double.infinity,
    this.lastItemTargetHeight = 20,
    this.addLastItemTargetHeightToTop = false,
    this.columnDragHandle,
    this.itemDragHandle,
    this.constrainDraggingAxis = true,
    this.disableScrolling = false,
  });
  final _OnPointerMove? onPointerMove;
  final _OnPointerUp? onPointerUp;
  final _OnPointerDown? onPointerDown;
  final _OnItemReordered? onItemReordered;
  final OnItemDropOnLastTarget? onItemDropOnLastTarget;
  final _OnColumnReordered? onColumnReordered;
  final ColumnOnWillAccept? columnOnWillAccept;
  final ColumnTargetOnWillAccept? columnTargetOnWillAccept;
  final OnColumnDraggingChanged? onColumnDraggingChanged;
  final ItemOnWillAccept? itemOnWillAccept;
  final ItemTargetOnWillAccept? itemTargetOnWillAccept;
  final OnItemDraggingChanged? onItemDraggingChanged;
  final CrossAxisAlignment verticalAlignment;
  final double? columnDraggingWidth;
  final bool dragOnLongPress;
  final int itemSizeAnimationDuration;
  final Widget? itemGhost;
  final double itemGhostOpacity;
  final Widget? itemDivider;
  final double? itemDraggingWidth;
  final Decoration? itemDecorationWhileDragging;
  final int columnSizeAnimationDuration;
  final Widget? columnGhost;
  final double columnGhostOpacity;
  final EdgeInsets? columnPadding;
  final Decoration? columnDecoration;
  final Decoration? columnDecorationWhileDragging;
  final double columnWidth;
  final double lastItemTargetHeight;
  final bool addLastItemTargetHeightToTop;
  final MTDragHandle? columnDragHandle;
  final MTDragHandle? itemDragHandle;
  final bool constrainDraggingAxis;
  final bool disableScrolling;
}
