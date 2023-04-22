// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';
import 'icons_workspace.dart';
import 'mt_constrained.dart';

class MTLimitBadge extends StatelessWidget {
  const MTLimitBadge({required this.child, required this.showBadge});
  final Widget child;
  final bool showBadge;

  static const _badgeSize = P2;

  @override
  Widget build(BuildContext context) {
    return MTConstrained(
      Stack(
        children: [
          Positioned(
            top: DEF_BORDER_WIDTH / 2,
            child: Container(
              width: _badgeSize * 2,
              height: MIN_BTN_HEIGHT - DEF_BORDER_WIDTH,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS),
                color: warningColor.resolve(context),
              ),
              child: Row(children: const [SizedBox(width: P_6), RoubleIcon(size: P2, color: lightBackgroundColor)]),
            ),
          ),
          Padding(padding: EdgeInsets.only(left: showBadge ? _badgeSize : 0), child: child),
        ],
      ),
    );
  }
}
