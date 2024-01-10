// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import 'dd_column_interface.dart';
import 'dd_parameters.dart';
import 'measure_size.dart';

class MTDragNDropColumnWrapper extends StatefulWidget {
  const MTDragNDropColumnWrapper({required this.ddColumn, required this.parameters, super.key});
  final MTDragNDropColumnInterface ddColumn;
  final MTDragNDropParameters parameters;

  @override
  State<StatefulWidget> createState() => _MTDragNDropColumnWrapper();
}

class _MTDragNDropColumnWrapper extends State<MTDragNDropColumnWrapper> with TickerProviderStateMixin {
  MTDragNDropColumnInterface? _hoveredDraggable;

  bool _dragging = false;
  Size _containerSize = Size.zero;
  Size _dragHandleSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    final ddColumnContent = widget.ddColumn.generateWidget(widget.parameters);

    Widget draggable;
    if (widget.ddColumn.canDrag) {
      if (widget.parameters.columnDragHandle != null) {
        final Widget dragHandle = MouseRegion(
          cursor: SystemMouseCursors.grab,
          child: widget.parameters.columnDragHandle,
        );

        draggable = MTMeasureSize(
          onSizeChange: (size) {
            setState(() => _containerSize = size!);
          },
          child: Stack(
            children: [
              Visibility(
                visible: !_dragging,
                child: ddColumnContent,
              ),
              Positioned(
                right: widget.parameters.columnDragHandle!.onLeft ? null : 0,
                left: widget.parameters.columnDragHandle!.onLeft ? 0 : null,
                top: _dragHandleDistanceFromTop(),
                child: Draggable<MTDragNDropColumnInterface>(
                  data: widget.ddColumn,
                  feedback: Transform.translate(
                    offset: _feedbackContainerOffset(),
                    child: _feedbackWithHandle(ddColumnContent, dragHandle),
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
                    child: dragHandle,
                  ),
                ),
              ),
            ],
          ),
        );
      } else if (widget.parameters.dragOnLongPress) {
        draggable = LongPressDraggable<MTDragNDropColumnInterface>(
          data: widget.ddColumn,
          feedback: _feedbackWithoutHandle(context, ddColumnContent),
          childWhenDragging: Container(),
          onDragStarted: () => _setDragging(true),
          onDragCompleted: () => _setDragging(false),
          onDraggableCanceled: (_, __) => _setDragging(false),
          onDragEnd: (_) => _setDragging(false),
          child: ddColumnContent,
        );
      } else {
        draggable = Draggable<MTDragNDropColumnInterface>(
          data: widget.ddColumn,
          feedback: _feedbackWithoutHandle(context, ddColumnContent),
          childWhenDragging: Container(),
          onDragStarted: () => _setDragging(true),
          onDragCompleted: () => _setDragging(false),
          onDraggableCanceled: (_, __) => _setDragging(false),
          onDragEnd: (_) => _setDragging(false),
          child: ddColumnContent,
        );
      }
    } else {
      draggable = ddColumnContent;
    }

    final rowOrColumnChildren = <Widget>[
      AnimatedSize(
        duration: Duration(milliseconds: widget.parameters.columnSizeAnimationDuration),
        alignment: Alignment.centerLeft,
        child: _hoveredDraggable != null
            ? Opacity(
                opacity: widget.parameters.columnGhostOpacity,
                child: widget.parameters.columnGhost ??
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: widget.parameters.columnPadding!.horizontal),
                      child: _hoveredDraggable!.generateWidget(widget.parameters),
                    ),
              )
            : Container(),
      ),
      Listener(
        onPointerMove: _onPointerMove,
        onPointerDown: widget.parameters.onPointerDown,
        onPointerUp: widget.parameters.onPointerUp,
        child: draggable,
      ),
    ];

    return Stack(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rowOrColumnChildren,
        ),
        Positioned.fill(
          child: DragTarget<MTDragNDropColumnInterface>(
            builder: (context, candidateData, rejectedData) {
              if (candidateData.isNotEmpty) {}
              return Container();
            },
            onWillAccept: (incoming) {
              bool accept = true;
              if (widget.parameters.columnOnWillAccept != null) {
                accept = widget.parameters.columnOnWillAccept!(incoming, widget.ddColumn);
              }
              if (accept && mounted) {
                setState(() {
                  _hoveredDraggable = incoming;
                });
              }
              return accept;
            },
            onLeave: (incoming) {
              if (_hoveredDraggable != null) {
                if (mounted) {
                  setState(() {
                    _hoveredDraggable = null;
                  });
                }
              }
            },
            onAccept: (incoming) {
              if (mounted) {
                setState(() {
                  widget.parameters.onColumnReordered!(incoming, widget.ddColumn);
                  _hoveredDraggable = null;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Material _feedbackWithHandle(Widget ddColumnContent, Widget dragHandle) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: widget.parameters.columnDecorationWhileDragging,
        child: SizedBox(
          width: widget.parameters.columnDraggingWidth ?? _containerSize.width,
          child: Stack(
            children: [
              Directionality(
                textDirection: Directionality.of(context),
                child: ddColumnContent,
              ),
              Positioned(
                right: widget.parameters.columnDragHandle!.onLeft ? null : 0,
                left: widget.parameters.columnDragHandle!.onLeft ? 0 : null,
                top: widget.parameters.columnDragHandle!.verticalAlignment == MTDragHandleVerticalAlignment.bottom ? null : 0,
                bottom: widget.parameters.columnDragHandle!.verticalAlignment == MTDragHandleVerticalAlignment.top ? null : 0,
                child: dragHandle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _feedbackWithoutHandle(BuildContext context, Widget ddColumnContent) {
    return SizedBox(
      width: widget.parameters.columnDraggingWidth ?? widget.parameters.columnWidth,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: widget.parameters.columnDecorationWhileDragging,
          child: Directionality(
            textDirection: Directionality.of(context),
            child: ddColumnContent,
          ),
        ),
      ),
    );
  }

  double _dragHandleDistanceFromTop() {
    switch (widget.parameters.columnDragHandle!.verticalAlignment) {
      case MTDragHandleVerticalAlignment.top:
        return 0;
      case MTDragHandleVerticalAlignment.center:
        return (_containerSize.height / 2.0) - (_dragHandleSize.height / 2.0);
      case MTDragHandleVerticalAlignment.bottom:
        return _containerSize.height - _dragHandleSize.height;
      default:
        return 0;
    }
  }

  Offset _feedbackContainerOffset() {
    double xOffset;
    double yOffset;
    if (widget.parameters.columnDragHandle!.onLeft) {
      xOffset = 0;
    } else {
      xOffset = -_containerSize.width + _dragHandleSize.width;
    }
    if (widget.parameters.columnDragHandle!.verticalAlignment == MTDragHandleVerticalAlignment.bottom) {
      yOffset = -_containerSize.height + _dragHandleSize.width;
    } else {
      yOffset = 0;
    }

    return Offset(xOffset, yOffset);
  }

  void _setDragging(bool dragging) {
    if (_dragging != dragging && mounted) {
      setState(() {
        _dragging = dragging;
      });
      if (widget.parameters.onColumnDraggingChanged != null) {
        widget.parameters.onColumnDraggingChanged!(widget.ddColumn, dragging);
      }
    }
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (_dragging) {
      widget.parameters.onPointerMove!(event);
    }
  }
}
