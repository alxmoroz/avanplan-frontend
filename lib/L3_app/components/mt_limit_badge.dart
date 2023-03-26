// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';
import 'icons_workspace.dart';

class MTLimitBadge extends StatelessWidget {
  const MTLimitBadge({required this.child, required this.showBadge});
  final Widget child;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Stack(
        children: [
          Positioned(
            top: DEF_BORDER_WIDTH / 2,
            left: P,
            child: Container(
              width: MIN_BTN_HEIGHT,
              height: MIN_BTN_HEIGHT - DEF_BORDER_WIDTH,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS),
                color: warningColor.resolve(context),
              ),
              alignment: Alignment.centerLeft,
              child: const RoubleIcon(size: P2, color: lightBackgroundColor),
            ),
          ),
          child,
        ],
      )
    ]);
  }
}
