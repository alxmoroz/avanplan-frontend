import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import 'drag_and_drop_builder_parameters.dart';
import 'drag_and_drop_item.dart';
import 'drag_and_drop_item_target.dart';
import 'drag_and_drop_item_wrapper.dart';
import 'drag_and_drop_list_interface.dart';

class DragAndDropList implements DragAndDropListInterface {
  DragAndDropList({
    required this.children,
    this.header,
    this.footer,
    this.contentsWhenEmpty,
    this.lastTarget,
    this.decoration,
    this.canDrag = true,
  });

  final Widget? header;
  final Widget? footer;
  final Widget? contentsWhenEmpty;
  final Widget? lastTarget;
  final Decoration? decoration;

  @override
  final List<DragAndDropItem> children;

  @override
  final bool canDrag;

  static const _borderRadius = BorderRadius.all(Radius.circular(DEF_BORDER_RADIUS));

  @override
  Widget generateWidget(DragAndDropBuilderParameters params) {
    final lastItemTargetHeight = params.lastItemTargetHeight;

    return Builder(
      builder: (context) => Container(
        clipBehavior: Clip.hardEdge,
        width: params.listWidth,
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
            MediaQuery(
              data: const MediaQueryData(
                padding: EdgeInsets.only(
                  top: P8,
                  // bottom: bbHeight,
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  if (children.isNotEmpty) ...[
                    if (params.addLastItemTargetHeightToTop) SizedBox(height: lastItemTargetHeight),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: children.length,
                      itemBuilder: (_, index) => DragAndDropItemWrapper(
                        child: children[index],
                        parameters: params,
                      ),
                    ),
                  ] else
                    contentsWhenEmpty ?? const BaseText.f2('Empty list'),
                  DragAndDropItemTarget(
                    parent: this,
                    parameters: params,
                    onReorderOrAdd: params.onItemDropOnLastTarget!,
                    child: lastTarget ?? SizedBox(height: lastItemTargetHeight),
                  ),
                  if (footer != null) footer!,
                ],
              ),
            ),
            if (header != null)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: MTAppBar(bgColor: b2Color, middle: header, leading: const SizedBox()),
              ),
            // if (bottomBar != null)
            //   Positioned(
            //     left: 0,
            //     right: 0,
            //     bottom: 0,
            //     child: bottomBar!,
            //   ),
          ],
        ),
      ),
    );
  }
}
