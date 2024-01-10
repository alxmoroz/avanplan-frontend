// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import 'dd_item.dart';
import 'dd_parameters.dart';
import 'measure_size.dart';

class MTDragNDropItemWrapper extends StatefulWidget {
  const MTDragNDropItemWrapper({required this.child, required this.parameters, super.key});
  final MTDragNDropItem child;
  final MTDragNDropParameters? parameters;

  @override
  State<StatefulWidget> createState() => _MTDragNDropItemWrapper();
}

class _MTDragNDropItemWrapper extends State<MTDragNDropItemWrapper> with TickerProviderStateMixin {
  MTDragNDropItem? _hoveredDraggable;

  bool _dragging = false;
  Size _containerSize = Size.zero;
  Size _dragHandleSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    Widget draggable;
    if (widget.child.canDrag) {
      if (widget.parameters!.itemDragHandle != null) {
        final Widget feedback = SizedBox(
          width: widget.parameters!.itemDraggingWidth ?? _containerSize.width,
          child: Stack(
            children: [
              widget.child.child,
              Positioned(
                right: widget.parameters!.itemDragHandle!.onLeft ? null : 0,
                left: widget.parameters!.itemDragHandle!.onLeft ? 0 : null,
                top: widget.parameters!.itemDragHandle!.verticalAlignment == MTDragHandleVerticalAlignment.bottom ? null : 0,
                bottom: widget.parameters!.itemDragHandle!.verticalAlignment == MTDragHandleVerticalAlignment.top ? null : 0,
                child: widget.parameters!.itemDragHandle!,
              ),
            ],
          ),
        );

        final positionedDragHandle = Positioned(
          right: widget.parameters!.itemDragHandle!.onLeft ? null : 0,
          left: widget.parameters!.itemDragHandle!.onLeft ? 0 : null,
          top: widget.parameters!.itemDragHandle!.verticalAlignment == MTDragHandleVerticalAlignment.bottom ? null : 0,
          bottom: widget.parameters!.itemDragHandle!.verticalAlignment == MTDragHandleVerticalAlignment.top ? null : 0,
          child: MouseRegion(
            cursor: SystemMouseCursors.grab,
            child: Draggable<MTDragNDropItem>(
              data: widget.child,
              feedback: Transform.translate(
                offset: _feedbackContainerOffset(),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: widget.parameters!.itemDecorationWhileDragging,
                    child: Directionality(
                      textDirection: Directionality.of(context),
                      child: feedback,
                    ),
                  ),
                ),
              ),
              childWhenDragging: Container(),
              onDragStarted: () => _setDragging(true),
              onDragCompleted: () => _setDragging(false),
              onDraggableCanceled: (_, __) => _setDragging(false),
              onDragEnd: (_) => _setDragging(false),
              child: MTMeasureSize(
                onSizeChange: (size) {
                  setState(() {
                    _dragHandleSize = size!;
                  });
                },
                child: widget.parameters!.itemDragHandle,
              ),
            ),
          ),
        );

        draggable = MTMeasureSize(
          onSizeChange: _setContainerSize,
          child: Stack(
            children: [
              Visibility(
                visible: !_dragging,
                child: widget.child.child,
              ),
              positionedDragHandle,
            ],
          ),
        );
      } else if (widget.parameters!.dragOnLongPress) {
        draggable = MTMeasureSize(
          onSizeChange: _setContainerSize,
          child: LongPressDraggable<MTDragNDropItem>(
            data: widget.child,
            feedback: SizedBox(
              width: widget.parameters!.itemDraggingWidth ?? _containerSize.width,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: widget.parameters!.itemDecorationWhileDragging,
                  child: Directionality(textDirection: Directionality.of(context), child: widget.child.feedbackWidget ?? widget.child.child),
                ),
              ),
            ),
            childWhenDragging: Container(),
            onDragStarted: () => _setDragging(true),
            onDragCompleted: () => _setDragging(false),
            onDraggableCanceled: (_, __) => _setDragging(false),
            onDragEnd: (_) => _setDragging(false),
            child: widget.child.child,
          ),
        );
      } else {
        draggable = MTMeasureSize(
          onSizeChange: _setContainerSize,
          child: Draggable<MTDragNDropItem>(
            data: widget.child,
            feedback: SizedBox(
              width: widget.parameters!.itemDraggingWidth ?? _containerSize.width,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: widget.parameters!.itemDecorationWhileDragging,
                  child: Directionality(
                    textDirection: Directionality.of(context),
                    child: widget.child.feedbackWidget ?? widget.child.child,
                  ),
                ),
              ),
            ),
            childWhenDragging: Container(),
            onDragStarted: () => _setDragging(true),
            onDragCompleted: () => _setDragging(false),
            onDraggableCanceled: (_, __) => _setDragging(false),
            onDragEnd: (_) => _setDragging(false),
            child: widget.child.child,
          ),
        );
      }
    } else {
      draggable = AnimatedSize(
        duration: Duration(milliseconds: widget.parameters!.itemSizeAnimationDuration),
        alignment: Alignment.bottomCenter,
        child: _hoveredDraggable != null ? Container() : widget.child.child,
      );
    }
    return Stack(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: widget.parameters!.verticalAlignment,
          children: <Widget>[
            AnimatedSize(
              duration: Duration(milliseconds: widget.parameters!.itemSizeAnimationDuration),
              alignment: Alignment.topLeft,
              child: _hoveredDraggable != null
                  ? Opacity(
                      opacity: widget.parameters!.itemGhostOpacity,
                      child: widget.parameters!.itemGhost ?? _hoveredDraggable!.child,
                    )
                  : Container(),
            ),
            Listener(
              onPointerMove: _onPointerMove,
              onPointerDown: widget.parameters!.onPointerDown,
              onPointerUp: widget.parameters!.onPointerUp,
              child: draggable,
            ),
          ],
        ),
        Positioned.fill(
          child: DragTarget<MTDragNDropItem>(
            builder: (context, candidateData, rejectedData) {
              if (candidateData.isNotEmpty) {}
              return Container();
            },
            onWillAccept: (incoming) {
              bool accept = true;
              if (widget.parameters!.itemOnWillAccept != null) {
                accept = widget.parameters!.itemOnWillAccept!(incoming, widget.child);
              }
              if (accept && mounted) {
                setState(() {
                  _hoveredDraggable = incoming;
                });
              }
              return accept;
            },
            onLeave: (incoming) {
              if (mounted) {
                setState(() {
                  _hoveredDraggable = null;
                });
              }
            },
            onAccept: (incoming) {
              if (mounted) {
                setState(() {
                  if (widget.parameters!.onItemReordered != null) {
                    widget.parameters!.onItemReordered!(incoming, widget.child);
                  }
                  _hoveredDraggable = null;
                });
              }
            },
          ),
        )
      ],
    );
  }

  Offset _feedbackContainerOffset() {
    double xOffset;
    double yOffset;
    if (widget.parameters!.itemDragHandle!.onLeft) {
      xOffset = 0;
    } else {
      xOffset = -_containerSize.width + _dragHandleSize.width;
    }
    if (widget.parameters!.itemDragHandle!.verticalAlignment == MTDragHandleVerticalAlignment.bottom) {
      yOffset = -_containerSize.height + _dragHandleSize.width;
    } else {
      yOffset = 0;
    }

    return Offset(xOffset, yOffset);
  }

  void _setContainerSize(Size? size) {
    if (mounted) {
      setState(() {
        _containerSize = size!;
      });
    }
  }

  void _setDragging(bool dragging) {
    if (_dragging != dragging && mounted) {
      setState(() {
        _dragging = dragging;
      });
      if (widget.parameters!.onItemDraggingChanged != null) {
        widget.parameters!.onItemDraggingChanged!(widget.child, dragging);
      }
    }
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (_dragging) {
      widget.parameters!.onPointerMove!(event);
    }
  }
}
