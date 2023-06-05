// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../main.dart';
import 'colors.dart';
import 'constants.dart';
import 'mt_toolbar.dart';

class _MTConstrainedBox extends StatelessWidget {
  const _MTConstrainedBox(this.child);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(rootKey.currentContext ?? context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: mq.size.height > SCR_S_HEIGHT ? mq.size.height - mq.padding.top - P : double.infinity),
      child: child,
    );
  }
}

class MTBottomSheet extends StatelessWidget {
  const MTBottomSheet({
    required this.body,
    this.topBar,
    this.topBarHeight,
    this.bottomBar,
    this.bottomBarHeight,
  });

  final Widget body;
  final Widget? topBar;
  final Widget? bottomBar;
  final double? topBarHeight;
  final double? bottomBarHeight;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final double bbHeight =
        bottomBar != null ? (bottomBarHeight ?? MTToolbar.topPadding + MTToolbar.bottomPadding + P + MIN_BTN_HEIGHT) : max(P2, mq.padding.bottom);
    final double tbHeight = topBar != null ? (topBarHeight ?? P2 * 2) : 0;
    return _MTConstrainedBox(
      GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Padding(
          padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: backgroundColor.resolve(context),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(DEF_BORDER_RADIUS), topRight: Radius.circular(DEF_BORDER_RADIUS)),
            ),
            child: Stack(
              children: [
                MediaQuery(
                  data: mq.copyWith(
                    padding: mq.padding.copyWith(
                      top: 0,
                      bottom: bbHeight,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: tbHeight),
                    child: body,
                  ),
                ),
                if (topBar != null) topBar!,
                if (bottomBar != null)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: MTToolbar(child: bottomBar!),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
