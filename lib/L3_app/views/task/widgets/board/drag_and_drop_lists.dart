import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../components/constants.dart';
import 'drag_and_drop_builder_parameters.dart';
import 'drag_and_drop_item.dart';
import 'drag_and_drop_item_target.dart';
import 'drag_and_drop_list_interface.dart';
import 'drag_and_drop_list_target.dart';
import 'drag_and_drop_list_wrapper.dart';
import 'drag_handle.dart';

export 'drag_and_drop_builder_parameters.dart';
export 'drag_and_drop_item.dart';
export 'drag_and_drop_item_target.dart';
export 'drag_and_drop_item_wrapper.dart';
export 'drag_and_drop_list.dart';
export 'drag_and_drop_list_target.dart';
export 'drag_and_drop_list_wrapper.dart';
export 'drag_handle.dart';

typedef OnItemReorder = void Function(
  int oldItemIndex,
  int oldListIndex,
  int newItemIndex,
  int newListIndex,
);
typedef OnItemAdd = void Function(
  DragAndDropItem newItem,
  int listIndex,
  int newItemIndex,
);
typedef OnListAdd = void Function(DragAndDropListInterface newList, int newListIndex);
typedef OnListReorder = void Function(int oldListIndex, int newListIndex);
typedef OnListDraggingChanged = void Function(
  DragAndDropListInterface? list,
  bool dragging,
);
typedef ListOnWillAccept = bool Function(
  DragAndDropListInterface? incoming,
  DragAndDropListInterface? target,
);
typedef ListOnAccept = void Function(
  DragAndDropListInterface incoming,
  DragAndDropListInterface target,
);
typedef ListTargetOnWillAccept = bool Function(DragAndDropListInterface? incoming, DragAndDropListTarget target);
typedef ListTargetOnAccept = void Function(DragAndDropListInterface incoming, DragAndDropListTarget target);
typedef OnItemDraggingChanged = void Function(
  DragAndDropItem item,
  bool dragging,
);
typedef ItemOnWillAccept = bool Function(
  DragAndDropItem? incoming,
  DragAndDropItem target,
);
typedef ItemOnAccept = void Function(
  DragAndDropItem incoming,
  DragAndDropItem target,
);
typedef ItemTargetOnWillAccept = bool Function(DragAndDropItem? incoming, DragAndDropItemTarget target);
typedef ItemTargetOnAccept = void Function(
  DragAndDropItem incoming,
  DragAndDropListInterface parentList,
  DragAndDropItemTarget target,
);

class DragAndDropLists extends StatefulWidget {
  DragAndDropLists({
    required this.children,
    required this.onItemReorder,
    required this.onListReorder,
    this.onItemAdd,
    this.onListAdd,
    this.onListDraggingChanged,
    this.listOnWillAccept,
    this.listOnAccept,
    this.listTargetOnWillAccept,
    this.listTargetOnAccept,
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
    this.listDraggingWidth,
    this.listTarget,
    this.listGhost,
    this.listGhostOpacity = 0.3,
    this.listSizeAnimationDurationMilliseconds = 150,
    this.listDragOnLongPress = true,
    this.listDecoration,
    this.listDecorationWhileDragging,
    this.listInnerDecoration,
    this.listDivider,
    this.listDividerOnLastChild = true,
    this.contentsWhenEmpty,
    this.listWidth = double.infinity,
    this.lastItemTargetHeight = 20,
    this.addLastItemTargetHeightToTop = false,
    this.lastListTargetSize = 110,
    this.sliverList = false,
    this.scrollController,
    this.disableScrolling = false,
    this.listDragHandle,
    this.itemDragHandle,
    this.constrainDraggingAxis = true,
    this.removeTopPadding = false,
    Key? key,
  }) : super(key: key) {
    if (listGhost == null && children.whereType<DragAndDropListExpansionInterface>().isNotEmpty)
      throw Exception('If using DragAndDropListExpansion, you must provide a non-null listGhost');
    if (sliverList && scrollController == null) {
      throw Exception('A scroll controller must be provided when using sliver lists');
    }
    if (listWidth == double.infinity) {
      throw Exception('A finite width must be provided when setting the axis to horizontal');
    }
    if (sliverList) {
      throw Exception('Combining a sliver list with a horizontal list is currently unsupported');
    }
  }

  final List<DragAndDropListInterface> children;
  final OnItemReorder onItemReorder;
  final OnListReorder onListReorder;
  final OnItemAdd? onItemAdd;
  final OnListAdd? onListAdd;

  /// Set in order to provide custom acceptance criteria for when a list can be
  /// dropped onto a specific other list
  final ListOnWillAccept? listOnWillAccept;

  /// Set in order to get the lists involved in a drag and drop operation after
  /// a list has been accepted. For general use cases where only reordering is
  /// necessary, only [onListReorder] or [onListAdd] is needed, and this should
  /// be left null. [onListReorder] or [onListAdd] will be called after this.
  final ListOnAccept? listOnAccept;

  /// Set in order to provide custom acceptance criteria for when a list can be
  /// dropped onto a specific target. This target always exists as the last
  /// target the DragAndDropLists, and also can be used independently.
  final ListTargetOnWillAccept? listTargetOnWillAccept;

  /// Set in order to get the list and target involved in a drag and drop
  /// operation after a list has been accepted. For general use cases where only
  /// reordering is necessary, only [onListReorder] or [onListAdd] is needed,
  /// and this should be left null. [onListReorder] or [onListAdd] will be
  /// called after this.
  final ListTargetOnAccept? listTargetOnAccept;

  /// Called when a list dragging is starting or ending
  final OnListDraggingChanged? onListDraggingChanged;

  /// Set in order to provide custom acceptance criteria for when a item can be
  /// dropped onto a specific other item
  final ItemOnWillAccept? itemOnWillAccept;

  /// Set in order to get the items involved in a drag and drop operation after
  /// an item has been accepted. For general use cases where only reordering is
  /// necessary, only [onItemReorder] or [onItemAdd] is needed, and this should
  /// be left null. [onItemReorder] or [onItemAdd] will be called after this.
  final ItemOnAccept? itemOnAccept;

  /// Set in order to provide custom acceptance criteria for when a item can be
  /// dropped onto a specific target. This target always exists as the last
  /// target for list of items, and also can be used independently.
  final ItemTargetOnWillAccept? itemTargetOnWillAccept;

  /// Set in order to get the item and target involved in a drag and drop
  /// operation after a item has been accepted. For general use cases where only
  /// reordering is necessary, only [onItemReorder] or [onItemAdd] is needed,
  /// and this should be left null. [onItemReorder] or [onItemAdd] will be
  /// called after this.
  final ItemTargetOnAccept? itemTargetOnAccept;

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

  /// The width of a list when dragging.
  final double? listDraggingWidth;

  /// The widget to be displayed as the last element in the DragAndDropLists,
  /// where a list will be accepted as the last list.
  final Widget? listTarget;

  /// The widget to be displayed at a potential list position while a list is being dragged.
  /// This must not be null when [children] includes one or more
  /// [DragAndDropListExpansion] or other class that inherit from [DragAndDropListExpansionInterface].
  final Widget? listGhost;

  /// The opacity of [listGhost]. It must be between 0 and 1.
  final double listGhostOpacity;

  /// The duration of the animation for the change in size when a [listGhost] is
  /// displayed at list position.
  final int listSizeAnimationDurationMilliseconds;

  /// Whether a list should be dragged on a long or short press.
  /// When true, the list will be dragged after a long press.
  /// When false, it will be dragged immediately.
  final bool listDragOnLongPress;

  /// The decoration surrounding a list.
  final Decoration? listDecoration;

  /// The decoration surrounding a list while it is in the process of being dragged.
  final Decoration? listDecorationWhileDragging;

  /// The decoration surrounding the inner list of items.
  final Decoration? listInnerDecoration;

  /// A widget that will be displayed between each individual list.
  final Widget? listDivider;

  /// Whether it should put a divider on the last list or not.
  final bool listDividerOnLastChild;

  /// A widget that will be displayed whenever a list contains no items.
  final Widget? contentsWhenEmpty;

  /// The width of each individual list. This must be set to a finite value
  final double listWidth;

  /// The height of the target for the last item in a list. This should be large
  /// enough to easily drag an item into the last position of a list.
  final double lastItemTargetHeight;

  /// Add the same height as the lastItemTargetHeight to the top of the list.
  /// This is useful when setting the [listInnerDecoration] to maintain visual
  /// continuity between the top and the bottom
  final bool addLastItemTargetHeightToTop;

  /// The height of the target for the last list. This should be large
  /// enough to easily drag a list to the last position in the DragAndDropLists.
  final double lastListTargetSize;

  /// Whether or not to return a widget or a sliver-compatible list.
  /// Set to true if using as a sliver. If true, a [scrollController] must be provided.
  /// Set to false if using in a widget only.
  final bool sliverList;

  /// A scroll controller that can be used for the scrolling of the first level lists.
  /// This must be set if [sliverList] is set to true.
  final ScrollController? scrollController;

  /// Set to true in order to disable all scrolling of the lists.
  /// Note: to disable scrolling for sliver lists, it is also necessary in your
  /// parent CustomScrollView to set physics to NeverScrollableScrollPhysics()
  final bool disableScrolling;

  /// Set a custom drag handle to use iOS-like handles to drag rather than long
  /// or short presses
  final DragHandle? listDragHandle;

  /// Set a custom drag handle to use iOS-like handles to drag rather than long
  /// or short presses
  final DragHandle? itemDragHandle;

  /// Constrain the dragging axis in a vertical list to only allow dragging on
  /// the vertical axis. By default this is set to true. This may be useful to
  /// disable when setting customDragTargets
  final bool constrainDraggingAxis;

  /// If you put a widget before DragAndDropLists there's an unexpected padding
  /// before the list renders. This is the default behaviour for ListView which
  /// is used internally. To remove the padding, set this field to true
  /// https://github.com/flutter/flutter/issues/14842#issuecomment-371344881
  final bool removeTopPadding;

  @override
  State<StatefulWidget> createState() => DragAndDropListsState();
}

class DragAndDropListsState extends State<DragAndDropLists> {
  late final ScrollController _scrollController;
  bool _pointerDown = false;
  double? _pointerYPosition;
  double? _pointerXPosition;
  bool _scrolling = false;
  final PageStorageBucket _pageStorageBucket = PageStorageBucket();

  @override
  void initState() {
    if (widget.scrollController != null)
      _scrollController = widget.scrollController!;
    else
      _scrollController = ScrollController();

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
    final parameters = DragAndDropBuilderParameters(
      listGhost: widget.listGhost,
      listGhostOpacity: widget.listGhostOpacity,
      listDraggingWidth: widget.listDraggingWidth,
      itemDraggingWidth: widget.itemDraggingWidth,
      listSizeAnimationDuration: widget.listSizeAnimationDurationMilliseconds,
      dragOnLongPress: widget.listDragOnLongPress,
      itemSizeAnimationDuration: widget.itemSizeAnimationDurationMilliseconds,
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      onPointerMove: _onPointerMove,
      onItemReordered: _internalOnItemReorder,
      onItemDropOnLastTarget: _internalOnItemDropOnLastTarget,
      onListReordered: _internalOnListReorder,
      onItemDraggingChanged: widget.onItemDraggingChanged,
      onListDraggingChanged: widget.onListDraggingChanged,
      listOnWillAccept: widget.listOnWillAccept,
      listTargetOnWillAccept: widget.listTargetOnWillAccept,
      itemOnWillAccept: widget.itemOnWillAccept,
      itemTargetOnWillAccept: widget.itemTargetOnWillAccept,
      itemGhostOpacity: widget.itemGhostOpacity,
      itemDivider: widget.itemDivider,
      itemDecorationWhileDragging: widget.itemDecorationWhileDragging,
      itemGhost: widget.itemGhost,
      listDecoration: widget.listDecoration,
      listDecorationWhileDragging: widget.listDecorationWhileDragging,
      listWidth: widget.listWidth,
      lastItemTargetHeight: widget.lastItemTargetHeight,
      addLastItemTargetHeightToTop: widget.addLastItemTargetHeightToTop,
      listDragHandle: widget.listDragHandle,
      itemDragHandle: widget.itemDragHandle,
      constrainDraggingAxis: widget.constrainDraggingAxis,
      disableScrolling: widget.disableScrolling,
    );

    final DragAndDropListTarget dragAndDropListTarget = DragAndDropListTarget(
      child: widget.listTarget,
      parameters: parameters,
      onDropOnLastTarget: _internalOnListDropOnLastTarget,
      lastListTargetSize: widget.lastListTargetSize,
    );

    if (widget.children.isNotEmpty) {
      Widget outerListHolder;

      if (widget.sliverList) {
        outerListHolder = _buildSliverList(dragAndDropListTarget, parameters);
      } else if (widget.disableScrolling) {
        outerListHolder = _buildUnscrollableList(dragAndDropListTarget, parameters);
      } else {
        outerListHolder = _buildListView(parameters, dragAndDropListTarget);
      }

      if (widget.children.whereType<DragAndDropListExpansionInterface>().isNotEmpty) {
        outerListHolder = PageStorage(
          child: outerListHolder,
          bucket: _pageStorageBucket,
        );
      }
      return outerListHolder;
    } else {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            widget.contentsWhenEmpty ?? const Text('Empty'),
            dragAndDropListTarget,
          ],
        ),
      );
    }
  }

  SliverList _buildSliverList(DragAndDropListTarget dragAndDropListTarget, DragAndDropBuilderParameters parameters) {
    final bool includeSeparators = widget.listDivider != null;
    final int childrenCount = _calculateChildrenCount(includeSeparators);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return _buildInnerList(index, childrenCount, dragAndDropListTarget, includeSeparators, parameters);
        },
        childCount: childrenCount,
      ),
    );
  }

  Widget _buildUnscrollableList(DragAndDropListTarget dragAndDropListTarget, DragAndDropBuilderParameters parameters) {
    return Row(
      children: _buildOuterList(dragAndDropListTarget, parameters),
    );
  }

  Widget _buildListView(DragAndDropBuilderParameters parameters, DragAndDropListTarget dragAndDropListTarget) {
    final Widget _listView = ListView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      padding: MediaQuery.paddingOf(context).add(const EdgeInsets.only(bottom: P3)),
      children: [
        const SizedBox(width: P3),
        ..._buildOuterList(dragAndDropListTarget, parameters),
        const SizedBox(width: P3),
      ],
    );

    return widget.removeTopPadding
        ? MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: _listView,
          )
        : _listView;
  }

  List<Widget> _buildOuterList(DragAndDropListTarget dragAndDropListTarget, DragAndDropBuilderParameters parameters) {
    final bool includeSeparators = widget.listDivider != null;
    final int childrenCount = _calculateChildrenCount(includeSeparators);

    return List.generate(childrenCount, (index) {
      return _buildInnerList(index, childrenCount, dragAndDropListTarget, includeSeparators, parameters);
    });
  }

  int _calculateChildrenCount(bool includeSeparators) {
    if (includeSeparators)
      return (widget.children.length * 2) - (widget.listDividerOnLastChild ? 0 : 1) + 1;
    else
      return widget.children.length + 1;
  }

  Widget _buildInnerList(
    int index,
    int childrenCount,
    DragAndDropListTarget dragAndDropListTarget,
    bool includeSeparators,
    DragAndDropBuilderParameters parameters,
  ) {
    if (index == childrenCount - 1) {
      return dragAndDropListTarget;
    } else if (includeSeparators && index.isOdd) {
      return widget.listDivider!;
    } else {
      return DragAndDropListWrapper(
        dragAndDropList: widget.children[(includeSeparators ? index / 2 : index).toInt()],
        parameters: parameters,
      );
    }
  }

  void _internalOnItemReorder(DragAndDropItem reordered, DragAndDropItem receiver) {
    if (widget.itemOnAccept != null) {
      widget.itemOnAccept!(reordered, receiver);
    }

    int reorderedListIndex = -1;
    int reorderedItemIndex = -1;
    int receiverListIndex = -1;
    int receiverItemIndex = -1;

    for (int i = 0; i < widget.children.length; i++) {
      if (reorderedItemIndex == -1) {
        reorderedItemIndex = widget.children[i].children!.indexWhere((e) => reordered == e);
        if (reorderedItemIndex != -1) {
          reorderedListIndex = i;
        }
      }
      if (receiverItemIndex == -1) {
        receiverItemIndex = widget.children[i].children!.indexWhere((e) => receiver == e);
        if (receiverItemIndex != -1) {
          receiverListIndex = i;
        }
      }
      if (reorderedItemIndex != -1 && receiverItemIndex != -1) {
        break;
      }
    }

    if (reorderedItemIndex == -1) {
      // this is a new item
      if (widget.onItemAdd != null) {
        widget.onItemAdd!(reordered, receiverListIndex, receiverItemIndex);
      }
    } else {
      if (reorderedListIndex == receiverListIndex && receiverItemIndex > reorderedItemIndex) {
        // same list, so if the new position is after the old position, the removal of the old item must be taken into account
        receiverItemIndex--;
      }

      widget.onItemReorder(reorderedItemIndex, reorderedListIndex, receiverItemIndex, receiverListIndex);
    }
  }

  void _internalOnListReorder(DragAndDropListInterface reordered, DragAndDropListInterface receiver) {
    final int reorderedListIndex = widget.children.indexWhere((e) => reordered == e);
    final int receiverListIndex = widget.children.indexWhere((e) => receiver == e);

    int newListIndex = receiverListIndex;

    if (widget.listOnAccept != null) {
      widget.listOnAccept!(reordered, receiver);
    }

    if (reorderedListIndex == -1) {
      // this is a new list
      if (widget.onListAdd != null) {
        widget.onListAdd!(reordered, newListIndex);
      }
    } else {
      if (newListIndex > reorderedListIndex) {
        // same list, so if the new position is after the old position, the removal of the old item must be taken into account
        newListIndex--;
      }
      widget.onListReorder(reorderedListIndex, newListIndex);
    }
  }

  void _internalOnItemDropOnLastTarget(DragAndDropItem newOrReordered, DragAndDropListInterface parentList, DragAndDropItemTarget receiver) {
    if (widget.itemTargetOnAccept != null) {
      widget.itemTargetOnAccept!(newOrReordered, parentList, receiver);
    }

    int reorderedListIndex = -1;
    int reorderedItemIndex = -1;
    int receiverListIndex = -1;
    int receiverItemIndex = -1;

    if (widget.children.isNotEmpty) {
      for (int i = 0; i < widget.children.length; i++) {
        if (reorderedItemIndex == -1) {
          reorderedItemIndex = widget.children[i].children?.indexWhere((e) => newOrReordered == e) ?? -1;
          if (reorderedItemIndex != -1) {
            reorderedListIndex = i;
          }
        }

        if (receiverItemIndex == -1 && widget.children[i] == parentList) {
          receiverListIndex = i;
          receiverItemIndex = widget.children[i].children?.length ?? -1;
        }

        if (reorderedItemIndex != -1 && receiverItemIndex != -1) {
          break;
        }
      }
    }

    if (reorderedItemIndex == -1) {
      if (widget.onItemAdd != null) {
        widget.onItemAdd!(newOrReordered, receiverListIndex, reorderedItemIndex);
      }
    } else {
      if (reorderedListIndex == receiverListIndex && receiverItemIndex > reorderedItemIndex) {
        // same list, so if the new position is after the old position, the removal of the old item must be taken into account
        receiverItemIndex--;
      }
      widget.onItemReorder(reorderedItemIndex, reorderedListIndex, receiverItemIndex, receiverListIndex);
    }
  }

  void _internalOnListDropOnLastTarget(DragAndDropListInterface newOrReordered, DragAndDropListTarget receiver) {
    // determine if newOrReordered is new or existing
    final int reorderedListIndex = widget.children.indexWhere((e) => newOrReordered == e);

    if (widget.listOnAccept != null) {
      widget.listTargetOnAccept!(newOrReordered, receiver);
    }

    if (reorderedListIndex >= 0) {
      widget.onListReorder(reorderedListIndex, widget.children.length - 1);
    } else {
      if (widget.onListAdd != null) {
        widget.onListAdd!(newOrReordered, reorderedListIndex);
      }
    }
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (_pointerDown) {
      _pointerYPosition = event.position.dy;
      _pointerXPosition = event.position.dx;

      _scrollList();
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

  Future<void> _scrollList() async {
    if (!widget.disableScrolling && !_scrolling && _pointerDown && _pointerYPosition != null && _pointerXPosition != null) {
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
        newOffset = _scrollListHorizontalLtr(topLeftOffset, bottomRightOffset);
      } else {
        newOffset = _scrollListHorizontalRtl(topLeftOffset, bottomRightOffset);
      }

      if (newOffset != null) {
        _scrolling = true;
        await _scrollController.animateTo(newOffset, duration: Duration(milliseconds: _duration), curve: Curves.linear);
        _scrolling = false;
        if (_pointerDown) {
          _scrollList();
        }
      }
    }
  }

  double? _scrollListHorizontalLtr(Offset topLeftOffset, Offset bottomRightOffset) {
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

  double? _scrollListHorizontalRtl(Offset topLeftOffset, Offset bottomRightOffset) {
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
