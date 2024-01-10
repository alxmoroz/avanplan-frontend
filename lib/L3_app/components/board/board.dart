// Copyright (c) 2024. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../constants.dart';
import 'dd_column_interface.dart';
import 'dd_column_target.dart';
import 'dd_column_wrapper.dart';
import 'dd_item.dart';
import 'dd_item_target.dart';
import 'dd_parameters.dart';

typedef OnColumnDraggingChanged = void Function(
  MTDragNDropColumnInterface? column,
  bool dragging,
);
typedef ColumnOnWillAccept = bool Function(
  MTDragNDropColumnInterface? incoming,
  MTDragNDropColumnInterface? target,
);
typedef ColumnTargetOnWillAccept = bool Function(MTDragNDropColumnInterface? incoming, MTDragNDropColumnTarget target);
typedef OnItemDraggingChanged = void Function(
  MTDragNDropItem item,
  bool dragging,
);
typedef ItemOnWillAccept = bool Function(
  MTDragNDropItem? incoming,
  MTDragNDropItem target,
);
typedef ItemTargetOnWillAccept = bool Function(MTDragNDropItem? incoming, MTDragNDropItemTarget target);

class MTBoard extends StatefulWidget {
  MTBoard({
    required this.children,
    required this.onItemReorder,
    required this.onColumnReorder,
    this.onItemAdd,
    this.onColumnAdd,
    this.onColumnDraggingChanged,
    this.columnOnWillAccept,
    this.columnOnAccept,
    this.columnTargetOnWillAccept,
    this.columnTargetOnAccept,
    this.onItemDraggingChanged,
    this.itemOnWillAccept,
    this.itemOnAccept,
    this.itemTargetOnWillAccept,
    this.itemTargetOnAccept,
    this.itemDraggingWidth,
    this.itemGhost,
    this.itemGhostOpacity = 0.3,
    this.itemSizeAnimationDurationMilliseconds = 150,
    this.itemDragOnLongPress = true,
    this.itemDecorationWhileDragging,
    this.itemDivider,
    this.columnDraggingWidth,
    this.columnTarget,
    this.columnGhost,
    this.columnGhostOpacity = 0.3,
    this.columnSizeAnimationDurationMilliseconds = 150,
    this.columnDragOnLongPress = true,
    this.columnDecoration,
    this.columnDecorationWhileDragging,
    this.columnInnerDecoration,
    this.columnDivider,
    this.columnDividerOnLastChild = true,
    this.contentsWhenEmpty,
    required this.columnWidth,
    this.lastItemTargetHeight = 20,
    this.addLastItemTargetHeightToTop = false,
    this.lastColumnTargetSize = 110,
    this.sliverColumn = false,
    this.scrollController,
    this.columnDragHandle,
    this.itemDragHandle,
    this.constrainDraggingAxis = true,
    this.removeTopPadding = false,
    super.key,
  }) {
    if (columnGhost == null && children.whereType<MTDragNDropColumnExpansionInterface>().isNotEmpty) {
      throw Exception('If using MTDragNDropColumnExpansion, you must provide a non-null columnGhost');
    }
    if (sliverColumn && scrollController == null) {
      throw Exception('A scroll controller must be provided when using sliver columns');
    }
    if (sliverColumn) {
      throw Exception('Combining a sliver column with a horizontal column is currently unsupported');
    }
  }

  final List<MTDragNDropColumnInterface> children;
  final void Function(
    int oldItemIndex,
    int oldColumnIndex,
    int newItemIndex,
    int newColumnIndex,
  ) onItemReorder;
  final void Function(int oldColumnIndex, int newColumnIndex) onColumnReorder;
  final void Function(
    MTDragNDropItem newItem,
    int columnIndex,
    int newItemIndex,
  )? onItemAdd;
  final void Function(MTDragNDropColumnInterface newColumn, int newColumnIndex)? onColumnAdd;

  /// Set in order to provide custom acceptance criteria for when a column can be
  /// dropped onto a specific other column
  final ColumnOnWillAccept? columnOnWillAccept;

  /// Set in order to get the columns involved in a drag and drop operation after
  /// a column has been accepted. For general use cases where only reordering is
  /// necessary, only [onColumnReorder] or [onColumnAdd] is needed, and this should
  /// be left null. [onColumnReorder] or [onColumnAdd] will be called after this.
  final void Function(
    MTDragNDropColumnInterface incoming,
    MTDragNDropColumnInterface target,
  )? columnOnAccept;

  /// Set in order to provide custom acceptance criteria for when a column can be
  /// dropped onto a specific target. This target always exists as the last
  /// target the MTDragNDropColumns, and also can be used independently.
  final ColumnTargetOnWillAccept? columnTargetOnWillAccept;

  /// Set in order to get the column and target involved in a drag and drop
  /// operation after a column has been accepted. For general use cases where only
  /// reordering is necessary, only [onColumnReorder] or [onColumnAdd] is needed,
  /// and this should be left null. [onColumnReorder] or [onColumnAdd] will be
  /// called after this.
  final void Function(MTDragNDropColumnInterface incoming, MTDragNDropColumnTarget target)? columnTargetOnAccept;

  /// Called when a column dragging is starting or ending
  final OnColumnDraggingChanged? onColumnDraggingChanged;

  /// Set in order to provide custom acceptance criteria for when a item can be
  /// dropped onto a specific other item
  final ItemOnWillAccept? itemOnWillAccept;

  /// Set in order to get the items involved in a drag and drop operation after
  /// an item has been accepted. For general use cases where only reordering is
  /// necessary, only [onItemReorder] or [onItemAdd] is needed, and this should
  /// be left null. [onItemReorder] or [onItemAdd] will be called after this.
  final void Function(
    MTDragNDropItem incoming,
    MTDragNDropItem target,
  )? itemOnAccept;

  /// Set in order to provide custom acceptance criteria for when a item can be
  /// dropped onto a specific target. This target always exists as the last
  /// target for column of items, and also can be used independently.
  final ItemTargetOnWillAccept? itemTargetOnWillAccept;

  /// Set in order to get the item and target involved in a drag and drop
  /// operation after a item has been accepted. For general use cases where only
  /// reordering is necessary, only [onItemReorder] or [onItemAdd] is needed,
  /// and this should be left null. [onItemReorder] or [onItemAdd] will be
  /// called after this.
  final void Function(
    MTDragNDropItem incoming,
    MTDragNDropColumnInterface parentColumn,
    MTDragNDropItemTarget target,
  )? itemTargetOnAccept;

  /// Called when an item dragging is starting or ending
  final OnItemDraggingChanged? onItemDraggingChanged;

  final double? itemDraggingWidth;
  final Widget? itemGhost;
  final double itemGhostOpacity;
  final int itemSizeAnimationDurationMilliseconds;
  final bool itemDragOnLongPress;

  /// The decoration surrounding an item while it is in the process of being dragged.
  final Decoration? itemDecorationWhileDragging;

  /// A widget that will be displayed between each individual item.
  final Widget? itemDivider;

  /// The width of a column when dragging.
  final double? columnDraggingWidth;

  /// The widget to be displayed as the last element in the MTDragNDropColumns,
  /// where a column will be accepted as the last column.
  final Widget? columnTarget;

  /// The widget to be displayed at a potential column position while a column is being dragged.
  /// This must not be null when [children] includes one or more
  /// [MTDragNDropColumnExpansion] or other class that inherit from [MTDragNDropColumnExpansionInterface].
  final Widget? columnGhost;

  /// The opacity of [columnGhost]. It must be between 0 and 1.
  final double columnGhostOpacity;

  /// The duration of the animation for the change in size when a [columnGhost] is
  /// displayed at column position.
  final int columnSizeAnimationDurationMilliseconds;

  /// Whether a column should be dragged on a long or short press.
  /// When true, the column will be dragged after a long press.
  /// When false, it will be dragged immediately.
  final bool columnDragOnLongPress;

  /// The decoration surrounding a column.
  final Decoration? columnDecoration;

  /// The decoration surrounding a column while it is in the process of being dragged.
  final Decoration? columnDecorationWhileDragging;

  /// The decoration surrounding the inner column of items.
  final Decoration? columnInnerDecoration;

  /// A widget that will be displayed between each individual column.
  final Widget? columnDivider;

  /// Whether it should put a divider on the last column or not.
  final bool columnDividerOnLastChild;

  /// A widget that will be displayed whenever a column contains no items.
  final Widget? contentsWhenEmpty;

  /// The width of each individual column. This must be set to a finite value
  final double columnWidth;

  /// The height of the target for the last item in a column. This should be large
  /// enough to easily drag an item into the last position of a column.
  final double lastItemTargetHeight;

  /// Add the same height as the lastItemTargetHeight to the top of the column.
  /// This is useful when setting the [columnInnerDecoration] to maintain visual
  /// continuity between the top and the bottom
  final bool addLastItemTargetHeightToTop;

  /// The height of the target for the last column. This should be large
  /// enough to easily drag a column to the last position in the MTDragNDropColumns.
  final double lastColumnTargetSize;

  /// Whether or not to return a widget or a sliver-compatible column.
  /// Set to true if using as a sliver. If true, a [scrollController] must be provided.
  /// Set to false if using in a widget only.
  final bool sliverColumn;

  /// A scroll controller that can be used for the scrolling of the first level columns.
  /// This must be set if [sliverColumn] is set to true.
  final ScrollController? scrollController;

  /// Set a custom drag handle to use iOS-like handles to drag rather than long
  /// or short presses
  final MTDragHandle? columnDragHandle;

  /// Set a custom drag handle to use iOS-like handles to drag rather than long
  /// or short presses
  final MTDragHandle? itemDragHandle;

  /// Constrain the dragging axis in a vertical column to only allow dragging on
  /// the vertical axis. By default this is set to true. This may be useful to
  /// disable when setting customDragTargets
  final bool constrainDraggingAxis;

  /// If you put a widget before MTDragNDropColumns there's an unexpected padding
  /// before the column renders. This is the default behaviour for ColumnView which
  /// is used internally. To remove the padding, set this field to true
  /// https://github.com/flutter/flutter/issues/14842#issuecomment-371344881
  final bool removeTopPadding;

  @override
  State<StatefulWidget> createState() => _MTBoardState();
}

class _MTBoardState extends State<MTBoard> {
  late final ScrollController _scrollController;
  bool _pointerDown = false;
  double? _pointerYPosition;
  double? _pointerXPosition;
  bool _scrolling = false;
  final PageStorageBucket _pageStorageBucket = PageStorageBucket();

  @override
  void initState() {
    if (widget.scrollController != null) {
      _scrollController = widget.scrollController!;
    } else {
      _scrollController = ScrollController();
    }

    super.initState();
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final parameters = MTDragNDropParameters(
      columnGhost: widget.columnGhost,
      columnGhostOpacity: widget.columnGhostOpacity,
      columnDraggingWidth: widget.columnDraggingWidth,
      itemDraggingWidth: widget.itemDraggingWidth,
      columnSizeAnimationDuration: widget.columnSizeAnimationDurationMilliseconds,
      dragOnLongPress: widget.columnDragOnLongPress,
      itemSizeAnimationDuration: widget.itemSizeAnimationDurationMilliseconds,
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      onPointerMove: _onPointerMove,
      onItemReordered: _internalOnItemReorder,
      onItemDropOnLastTarget: _internalOnItemDropOnLastTarget,
      onColumnReordered: _internalOnColumnReorder,
      onItemDraggingChanged: widget.onItemDraggingChanged,
      onColumnDraggingChanged: widget.onColumnDraggingChanged,
      columnOnWillAccept: widget.columnOnWillAccept,
      columnTargetOnWillAccept: widget.columnTargetOnWillAccept,
      itemOnWillAccept: widget.itemOnWillAccept,
      itemTargetOnWillAccept: widget.itemTargetOnWillAccept,
      itemGhostOpacity: widget.itemGhostOpacity,
      itemDivider: widget.itemDivider,
      itemDecorationWhileDragging: widget.itemDecorationWhileDragging,
      itemGhost: widget.itemGhost,
      columnDecoration: widget.columnDecoration,
      columnDecorationWhileDragging: widget.columnDecorationWhileDragging,
      columnWidth: widget.columnWidth,
      lastItemTargetHeight: widget.lastItemTargetHeight,
      addLastItemTargetHeightToTop: widget.addLastItemTargetHeightToTop,
      columnDragHandle: widget.columnDragHandle,
      itemDragHandle: widget.itemDragHandle,
      constrainDraggingAxis: widget.constrainDraggingAxis,
    );

    final MTDragNDropColumnTarget dragAndDropColumnTarget = MTDragNDropColumnTarget(
      parameters: parameters,
      onDropOnLastTarget: _internalOnColumnDropOnLastTarget,
      lastColumnTargetSize: widget.lastColumnTargetSize,
      child: widget.columnTarget,
    );

    if (widget.children.isNotEmpty) {
      Widget outerColumn;

      if (widget.sliverColumn) {
        outerColumn = _buildSliverColumn(dragAndDropColumnTarget, parameters);
      } else {
        outerColumn = _buildColumnView(parameters, dragAndDropColumnTarget);
      }

      if (widget.children.whereType<MTDragNDropColumnExpansionInterface>().isNotEmpty) {
        outerColumn = PageStorage(
          bucket: _pageStorageBucket,
          child: outerColumn,
        );
      }
      return outerColumn;
    } else {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            widget.contentsWhenEmpty ?? const Text('Empty'),
            dragAndDropColumnTarget,
          ],
        ),
      );
    }
  }

  SliverList _buildSliverColumn(MTDragNDropColumnTarget dragAndDropColumnTarget, MTDragNDropParameters parameters) {
    final bool includeSeparators = widget.columnDivider != null;
    final int childrenCount = _calculateChildrenCount(includeSeparators);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return _buildInnerColumn(index, childrenCount, dragAndDropColumnTarget, includeSeparators, parameters);
        },
        childCount: childrenCount,
      ),
    );
  }

  Widget _buildColumnView(MTDragNDropParameters parameters, MTDragNDropColumnTarget dragAndDropColumnTarget) {
    final Widget columnView = ListView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      padding: MediaQuery.paddingOf(context).add(const EdgeInsets.only(bottom: P3)),
      children: [
        const SizedBox(width: P3),
        ..._buildOuterColumn(dragAndDropColumnTarget, parameters),
        const SizedBox(width: P3),
      ],
    );

    return widget.removeTopPadding
        ? MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: columnView,
          )
        : columnView;
  }

  List<Widget> _buildOuterColumn(MTDragNDropColumnTarget dragAndDropColumnTarget, MTDragNDropParameters parameters) {
    final bool includeSeparators = widget.columnDivider != null;
    final int childrenCount = _calculateChildrenCount(includeSeparators);

    return List.generate(childrenCount, (index) {
      return _buildInnerColumn(index, childrenCount, dragAndDropColumnTarget, includeSeparators, parameters);
    });
  }

  int _calculateChildrenCount(bool includeSeparators) {
    if (includeSeparators) {
      return (widget.children.length * 2) - (widget.columnDividerOnLastChild ? 0 : 1) + 1;
    } else {
      return widget.children.length + 1;
    }
  }

  Widget _buildInnerColumn(
    int index,
    int childrenCount,
    MTDragNDropColumnTarget dragAndDropColumnTarget,
    bool includeSeparators,
    MTDragNDropParameters parameters,
  ) {
    if (index == childrenCount - 1) {
      return dragAndDropColumnTarget;
    } else if (includeSeparators && index.isOdd) {
      return widget.columnDivider!;
    } else {
      return MTDragNDropColumnWrapper(
        ddColumn: widget.children[(includeSeparators ? index / 2 : index).toInt()],
        parameters: parameters,
      );
    }
  }

  void _internalOnItemReorder(MTDragNDropItem reordered, MTDragNDropItem receiver) {
    if (widget.itemOnAccept != null) {
      widget.itemOnAccept!(reordered, receiver);
    }

    int reorderedColumnIndex = -1;
    int reorderedItemIndex = -1;
    int receiverColumnIndex = -1;
    int receiverItemIndex = -1;

    for (int i = 0; i < widget.children.length; i++) {
      if (reorderedItemIndex == -1) {
        reorderedItemIndex = widget.children[i].children!.indexWhere((e) => reordered == e);
        if (reorderedItemIndex != -1) {
          reorderedColumnIndex = i;
        }
      }
      if (receiverItemIndex == -1) {
        receiverItemIndex = widget.children[i].children!.indexWhere((e) => receiver == e);
        if (receiverItemIndex != -1) {
          receiverColumnIndex = i;
        }
      }
      if (reorderedItemIndex != -1 && receiverItemIndex != -1) {
        break;
      }
    }

    if (reorderedItemIndex == -1) {
      // this is a new item
      if (widget.onItemAdd != null) {
        widget.onItemAdd!(reordered, receiverColumnIndex, receiverItemIndex);
      }
    } else {
      if (reorderedColumnIndex == receiverColumnIndex && receiverItemIndex > reorderedItemIndex) {
        // same column, so if the new position is after the old position, the removal of the old item must be taken into account
        receiverItemIndex--;
      }

      widget.onItemReorder(reorderedItemIndex, reorderedColumnIndex, receiverItemIndex, receiverColumnIndex);
    }
  }

  void _internalOnColumnReorder(MTDragNDropColumnInterface reordered, MTDragNDropColumnInterface receiver) {
    final int reorderedColumnIndex = widget.children.indexWhere((e) => reordered == e);
    final int receiverColumnIndex = widget.children.indexWhere((e) => receiver == e);

    int newColumnIndex = receiverColumnIndex;

    if (widget.columnOnAccept != null) {
      widget.columnOnAccept!(reordered, receiver);
    }

    if (reorderedColumnIndex == -1) {
      // this is a new column
      if (widget.onColumnAdd != null) {
        widget.onColumnAdd!(reordered, newColumnIndex);
      }
    } else {
      if (newColumnIndex > reorderedColumnIndex) {
        // same column, so if the new position is after the old position, the removal of the old item must be taken into account
        newColumnIndex--;
      }
      widget.onColumnReorder(reorderedColumnIndex, newColumnIndex);
    }
  }

  void _internalOnItemDropOnLastTarget(MTDragNDropItem newOrReordered, MTDragNDropColumnInterface parentColumn, MTDragNDropItemTarget receiver) {
    if (widget.itemTargetOnAccept != null) {
      widget.itemTargetOnAccept!(newOrReordered, parentColumn, receiver);
    }

    int reorderedColumnIndex = -1;
    int reorderedItemIndex = -1;
    int receiverColumnIndex = -1;
    int receiverItemIndex = -1;

    if (widget.children.isNotEmpty) {
      for (int i = 0; i < widget.children.length; i++) {
        if (reorderedItemIndex == -1) {
          reorderedItemIndex = widget.children[i].children?.indexWhere((e) => newOrReordered == e) ?? -1;
          if (reorderedItemIndex != -1) {
            reorderedColumnIndex = i;
          }
        }

        if (receiverItemIndex == -1 && widget.children[i] == parentColumn) {
          receiverColumnIndex = i;
          receiverItemIndex = widget.children[i].children?.length ?? -1;
        }

        if (reorderedItemIndex != -1 && receiverItemIndex != -1) {
          break;
        }
      }
    }

    if (reorderedItemIndex == -1) {
      if (widget.onItemAdd != null) {
        widget.onItemAdd!(newOrReordered, receiverColumnIndex, reorderedItemIndex);
      }
    } else {
      if (reorderedColumnIndex == receiverColumnIndex && receiverItemIndex > reorderedItemIndex) {
        // same column, so if the new position is after the old position, the removal of the old item must be taken into account
        receiverItemIndex--;
      }
      widget.onItemReorder(reorderedItemIndex, reorderedColumnIndex, receiverItemIndex, receiverColumnIndex);
    }
  }

  void _internalOnColumnDropOnLastTarget(MTDragNDropColumnInterface newOrReordered, MTDragNDropColumnTarget receiver) {
    // determine if newOrReordered is new or existing
    final int reorderedColumnIndex = widget.children.indexWhere((e) => newOrReordered == e);

    if (widget.columnOnAccept != null) {
      widget.columnTargetOnAccept!(newOrReordered, receiver);
    }

    if (reorderedColumnIndex >= 0) {
      widget.onColumnReorder(reorderedColumnIndex, widget.children.length - 1);
    } else {
      if (widget.onColumnAdd != null) {
        widget.onColumnAdd!(newOrReordered, reorderedColumnIndex);
      }
    }
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (_pointerDown) {
      _pointerYPosition = event.position.dy;
      _pointerXPosition = event.position.dx;

      _scrollColumn();
    }
  }

  void _onPointerDown(PointerDownEvent event) {
    _pointerDown = true;
    _pointerYPosition = event.position.dy;
    _pointerXPosition = event.position.dx;
  }

  void _onPointerUp(PointerUpEvent event) {
    _pointerDown = false;
  }

  final int _duration = 30; // in ms
  final int _scrollAreaSize = 20;
  final double _overDragMin = 5.0;
  final double _overDragMax = 20.0;
  final double _overDragCoefficient = 3.3;

  Future<void> _scrollColumn() async {
    if (!_scrolling && _pointerDown && _pointerYPosition != null && _pointerXPosition != null) {
      double? newOffset;

      final rb = context.findRenderObject()!;
      late Size size;
      if (rb is RenderBox) {
        size = rb.size;
      } else if (rb is RenderSliver) {
        size = rb.paintBounds.size;
      }

      final topLeftOffset = localToGlobal(rb, Offset.zero);
      final bottomRightOffset = localToGlobal(rb, size.bottomRight(Offset.zero));

      final directionality = Directionality.of(context);
      if (directionality == TextDirection.ltr) {
        newOffset = _scrollColumnHorizontalLtr(topLeftOffset, bottomRightOffset);
      } else {
        newOffset = _scrollColumnHorizontalRtl(topLeftOffset, bottomRightOffset);
      }

      if (newOffset != null) {
        _scrolling = true;
        await _scrollController.animateTo(newOffset, duration: Duration(milliseconds: _duration), curve: Curves.linear);
        _scrolling = false;
        if (_pointerDown) {
          _scrollColumn();
        }
      }
    }
  }

  double? _scrollColumnHorizontalLtr(Offset topLeftOffset, Offset bottomRightOffset) {
    final double left = topLeftOffset.dx;
    final double right = bottomRightOffset.dx;
    double? newOffset;

    final pointerXPosition = _pointerXPosition;
    final scrollController = _scrollController;
    if (pointerXPosition != null) {
      if (pointerXPosition < (left + _scrollAreaSize) && scrollController.position.pixels > scrollController.position.minScrollExtent) {
        // scrolling toward minScrollExtent
        final overDrag = min((left + _scrollAreaSize) - pointerXPosition + _overDragMin, _overDragMax);
        newOffset = max(scrollController.position.minScrollExtent, scrollController.position.pixels - overDrag / _overDragCoefficient);
      } else if (pointerXPosition > (right - _scrollAreaSize) && scrollController.position.pixels < scrollController.position.maxScrollExtent) {
        // scrolling toward maxScrollExtent
        final overDrag = min(pointerXPosition - (right - _scrollAreaSize) + _overDragMin, _overDragMax);
        newOffset = min(scrollController.position.maxScrollExtent, scrollController.position.pixels + overDrag / _overDragCoefficient);
      }
    }

    return newOffset;
  }

  double? _scrollColumnHorizontalRtl(Offset topLeftOffset, Offset bottomRightOffset) {
    final double left = topLeftOffset.dx;
    final double right = bottomRightOffset.dx;
    double? newOffset;

    final pointerXPosition = _pointerXPosition;
    final scrollController = _scrollController;
    if (pointerXPosition != null) {
      if (pointerXPosition < (left + _scrollAreaSize) && scrollController.position.pixels < scrollController.position.maxScrollExtent) {
        // scrolling toward maxScrollExtent
        final overDrag = min((left + _scrollAreaSize) - pointerXPosition + _overDragMin, _overDragMax);
        newOffset = min(scrollController.position.maxScrollExtent, scrollController.position.pixels + overDrag / _overDragCoefficient);
      } else if (pointerXPosition > (right - _scrollAreaSize) && scrollController.position.pixels > scrollController.position.minScrollExtent) {
        // scrolling toward minScrollExtent
        final overDrag = min(pointerXPosition - (right - _scrollAreaSize) + _overDragMin, _overDragMax);
        newOffset = max(scrollController.position.minScrollExtent, scrollController.position.pixels - overDrag / _overDragCoefficient);
      }
    }

    return newOffset;
  }

  static Offset localToGlobal(RenderObject object, Offset point, {RenderObject? ancestor}) {
    return MatrixUtils.transformPoint(object.getTransformTo(ancestor), point);
  }
}
