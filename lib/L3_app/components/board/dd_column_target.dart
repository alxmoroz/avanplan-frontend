// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dd_column_interface.dart';
import 'dd_parameters.dart';

class MTDragNDropColumnTarget extends StatefulWidget {
  const MTDragNDropColumnTarget({
    this.child,
    required this.parameters,
    required this.onDropOnLastTarget,
    this.lastColumnTargetSize = 110,
    super.key,
  });

  final Widget? child;
  final MTDragNDropParameters parameters;
  final void Function(
    MTDragNDropColumnInterface newOrReordered,
    MTDragNDropColumnTarget receiver,
  ) onDropOnLastTarget;
  final double lastColumnTargetSize;

  @override
  State<StatefulWidget> createState() => _MTDragNDropColumnTarget();
}

class _MTDragNDropColumnTarget extends State<MTDragNDropColumnTarget> with TickerProviderStateMixin {
  MTDragNDropColumnInterface? _hoveredDraggable;

  @override
  Widget build(BuildContext context) {
    Widget visibleContents = Column(
      children: <Widget>[
        AnimatedSize(
          duration: Duration(milliseconds: widget.parameters.columnSizeAnimationDuration),
          alignment: Alignment.centerLeft,
          child: _hoveredDraggable != null
              ? Opacity(
                  opacity: widget.parameters.columnGhostOpacity,
                  child: widget.parameters.columnGhost ?? _hoveredDraggable!.generateWidget(widget.parameters),
                )
              : Container(),
        ),
        widget.child ?? Container(),
      ],
    );

    if (widget.parameters.columnPadding != null) {
      visibleContents = Padding(
        padding: widget.parameters.columnPadding!,
        child: visibleContents,
      );
    }

    return Stack(
      children: <Widget>[
        visibleContents,
        Positioned.fill(
          child: DragTarget<MTDragNDropColumnInterface>(
            builder: (context, candidateData, rejectedData) {
              if (candidateData.isNotEmpty) {}
              return Container();
            },
            onWillAccept: (incoming) {
              bool accept = true;
              if (widget.parameters.columnTargetOnWillAccept != null) {
                accept = widget.parameters.columnTargetOnWillAccept!(incoming, widget);
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
                  widget.onDropOnLastTarget(incoming, widget);
                  _hoveredDraggable = null;
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
