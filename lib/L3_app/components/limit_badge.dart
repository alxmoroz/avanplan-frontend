// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'icons_workspace.dart';

class MTLimitBadge extends StatelessWidget {
  const MTLimitBadge({
    required this.child,
    required this.showBadge,
    this.margin,
  });

  final Widget child;
  final bool showBadge;
  final EdgeInsets? margin;

  static const _iconSize = P5;
  static const _badgeSize = MIN_BTN_HEIGHT + _iconSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: margin ?? EdgeInsets.zero,
        child: showBadge
            ? Stack(
                fit: StackFit.passthrough,
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: MIN_BTN_HEIGHT - DEF_BORDER_WIDTH,
                    width: _badgeSize,
                    padding: const EdgeInsets.only(left: MIN_BTN_HEIGHT / 4 - P_2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(DEF_BTN_BORDER_RADIUS),
                      color: warningColor.resolve(context),
                    ),
                    child: const RoubleIcon(size: _iconSize, color: b3Color),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: _badgeSize / 2),
                    child: child,
                  ),
                ],
              )
            : child);
  }
}
