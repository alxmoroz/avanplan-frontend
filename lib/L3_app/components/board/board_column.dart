// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../theme/colors.dart';
import '../constants.dart';
import 'dd_column_interface.dart';
import 'dd_item.dart';
import 'dd_item_target.dart';
import 'dd_item_wrapper.dart';
import 'dd_parameters.dart';

class MTBoardColumn implements MTDragNDropColumnInterface {
  MTBoardColumn({
    required this.children,
    this.header,
    this.footer,
    this.contentsWhenEmpty,
    this.lastTarget,
    this.decoration,
    this.canDrag = true,
    this.hasTarget = true,
  });

  final Widget? header;
  final Widget? footer;
  final Widget? contentsWhenEmpty;
  final Widget? lastTarget;
  final bool hasTarget;
  final Decoration? decoration;

  @override
  final List<MTDragNDropItem> children;

  @override
  final bool canDrag;

  static const _borderRadius = BorderRadius.all(Radius.circular(DEF_BORDER_RADIUS));
  static const _headerHeight = P8;
  static const _footerHeight = P8;

  @override
  Widget generateWidget(MTDragNDropParameters params) {
    final lastItemTargetHeight = params.lastItemTargetHeight;

    return Builder(
      builder: (context) => Container(
        clipBehavior: Clip.hardEdge,
        width: params.columnWidth,
        foregroundDecoration: BoxDecoration(
          borderRadius: _borderRadius,
          border: Border.all(width: 1, color: b1Color.resolve(context)),
        ),
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          color: b2Color.resolve(context),
        ),
        child: Stack(
          children: [
            hasTarget
                ? MediaQuery(
                    data:
                        MediaQueryData(padding: EdgeInsets.only(top: header != null ? _headerHeight : 0, bottom: footer != null ? _footerHeight : 0)),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        if (children.isNotEmpty) ...[
                          if (params.addLastItemTargetHeightToTop) SizedBox(height: lastItemTargetHeight),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: children.length,
                            itemBuilder: (_, index) => MTDragNDropItemWrapper(
                              child: children[index],
                              parameters: params,
                            ),
                          ),
                        ] else
                          contentsWhenEmpty ?? const SizedBox(),
                        MTDragNDropItemTarget(
                          parent: this,
                          parameters: params,
                          onReorderOrAdd: params.onItemDropOnLastTarget!,
                          child: lastTarget ?? SizedBox(height: lastItemTargetHeight),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            if (header != null) Container(color: b2Color.resolve(context), height: _headerHeight, child: header),
            if (footer != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(color: b2Color.resolve(context), height: _footerHeight, child: footer),
              ),
          ],
        ),
      ),
    );
  }
}
