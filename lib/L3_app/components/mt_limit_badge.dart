// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';
import 'icons_workspace.dart';

class MTLimitBadge extends StatelessWidget {
  const MTLimitBadge({required this.child, required this.showBadge});
  final Widget child;
  final bool showBadge;

  static const _badgeSize = P2;

  @override
  Widget build(BuildContext context) {
    return showBadge
        ? Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: MIN_BTN_HEIGHT - DEF_BORDER_WIDTH,
                width: _badgeSize * 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(DEF_BTN_BORDER_RADIUS),
                  color: warningColor.resolve(context),
                ),
                child: Row(children: const [
                  SizedBox(width: P_6),
                  RoubleIcon(size: P2, color: lightBackgroundColor),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: _badgeSize),
                child: SizedBox(child: child, width: double.infinity),
              ),
            ],
          )
        : child;
  }
}
