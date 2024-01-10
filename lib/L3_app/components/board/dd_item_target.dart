// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dd_column_interface.dart';
import 'dd_item.dart';
import 'dd_parameters.dart';

class MTDragNDropItemTarget extends StatefulWidget {
  const MTDragNDropItemTarget({required this.child, required this.onReorderOrAdd, required this.parameters, this.parent, super.key});
  final Widget child;
  final MTDragNDropColumnInterface? parent;
  final MTDragNDropParameters parameters;
  final OnItemDropOnLastTarget onReorderOrAdd;

  @override
  State<StatefulWidget> createState() => _MTDragNDropItemTarget();
}

class _MTDragNDropItemTarget extends State<MTDragNDropItemTarget> with TickerProviderStateMixin {
  MTDragNDropItem? _hoveredDraggable;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: widget.parameters.verticalAlignment,
          children: <Widget>[
            AnimatedSize(
              duration: Duration(milliseconds: widget.parameters.itemSizeAnimationDuration),
              alignment: Alignment.bottomCenter,
              child: _hoveredDraggable != null
                  ? Opacity(
                      opacity: widget.parameters.itemGhostOpacity,
                      child: widget.parameters.itemGhost ?? _hoveredDraggable!.child,
                    )
                  : Container(),
            ),
            widget.child,
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
              if (widget.parameters.itemTargetOnWillAccept != null) {
                accept = widget.parameters.itemTargetOnWillAccept!(incoming, widget);
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
                  widget.onReorderOrAdd(incoming, widget.parent!, widget);
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
