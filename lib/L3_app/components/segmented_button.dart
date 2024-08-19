// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'list_tile.dart';
import 'text.dart';

class MTSegmentedButtonItem {
  MTSegmentedButtonItem(this.value, this.title);
  final String value;
  final String title;
}

class MTSegmentedButton extends StatelessWidget {
  const MTSegmentedButton(
    this.items, {
    this.onChanged,
    this.value,
    this.padding,
    super.key,
  });
  final List<MTSegmentedButtonItem> items;
  final Function(String?)? onChanged;
  final String? value;
  final EdgeInsets? padding;

  Widget _segment(BuildContext context, MTSegmentedButtonItem item, double width) {
    return Flexible(
      child: MTListTile(
        middle: BaseText.f2(item.title, maxLines: 1, align: TextAlign.center),
        minHeight: MIN_BTN_HEIGHT,
        padding: EdgeInsets.zero,
        color: f3Color.withOpacity(0.2),
        bottomDivider: false,
        onTap: onChanged != null ? () => onChanged!(item.value) : null,
      ),
    );
  }

  Widget _activeSegment(BuildContext context, double width) {
    int index = 0;
    MTSegmentedButtonItem? item;

    for (; index < items.length; index++) {
      item = items[index];
      if (item.value == value) {
        break;
      }
    }

    const innerBorderW = P_2;
    const extraW = P2;

    return item != null
        ? AnimatedPositioned(
            top: innerBorderW,
            left: index < items.length - 1 ? (index == 0 ? innerBorderW : -extraW / 2) + index * width : null,
            right: index == items.length - 1 ? innerBorderW : null,
            width: width + P2,
            height: MIN_BTN_HEIGHT - 2 * innerBorderW,
            duration: const Duration(milliseconds: 150),
            child: Container(
              alignment: Alignment.center,
              height: MIN_BTN_HEIGHT,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(MIN_BTN_HEIGHT / 2)),
                color: b3Color.resolve(context),
              ),
              child: BaseText(item.title, color: mainColor, maxLines: 1),
            ),
          )
        : const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: LayoutBuilder(
        builder: (_, size) {
          final btnWidth = size.maxWidth / 3;
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(MIN_BTN_HEIGHT / 2))),
            child: Stack(
              children: [
                Row(children: [for (MTSegmentedButtonItem i in items) _segment(context, i, btnWidth)]),
                _activeSegment(context, btnWidth),
              ],
            ),
          );
        },
      ),
    );
  }
}
