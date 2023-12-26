// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';

import 'adaptive.dart';
import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'material_wrapper.dart';

Color get barrierColor => b0Color.resolve(globalContext).withAlpha(220);

BoxConstraints dialogConstrains(double? maxWidth) => BoxConstraints(
      maxWidth: isBigScreen ? min(screenSize.width - P6, maxWidth ?? SCR_S_WIDTH) : double.infinity,
      maxHeight: isBigScreen ? screenSize.height - screenPadding.vertical - P6 : double.infinity,
    );

Widget constrainedDialog(Widget child, {double? maxWidth}) => UnconstrainedBox(
      child: Container(
        constraints: dialogConstrains(maxWidth),
        child: material(child),
      ),
    );

Future<T?> showMTDialog<T>(Widget child, {double? maxWidth}) async {
  return isBigScreen
      ? await showDialog<T?>(
          context: globalContext,
          barrierColor: barrierColor,
          useRootNavigator: false,
          useSafeArea: true,
          builder: (_) => constrainedDialog(child, maxWidth: maxWidth),
        )
      : await showModalBottomSheet<T?>(
          context: globalContext,
          barrierColor: barrierColor,
          isScrollControlled: true,
          useRootNavigator: false,
          useSafeArea: true,
          constraints: dialogConstrains(maxWidth),
          builder: (_) => child,
        );
}

class MTDialog extends StatelessWidget {
  const MTDialog({
    required this.body,
    this.topBar,
    this.topBarHeight,
    this.bottomBar,
    this.bottomBarHeight,
    this.bottomBarColor,
    this.rightBar,
    this.bgColor,
    this.scrollController,
  });

  final Widget body;

  final Widget? topBar;
  final double? topBarHeight;

  final Widget? bottomBar;
  final double? bottomBarHeight;

  final Widget? rightBar;

  final Color? bottomBarColor;
  final Color? bgColor;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final big = isBigScreen;
    final bPadding = big ? P2 : defaultBottomPadding(context);
    final mq = MediaQuery.of(context);
    final double bbHeight = bPadding + (bottomBar != null ? (bottomBarHeight ?? P2 + MIN_BTN_HEIGHT) : 0);
    final double tbHeight = topBar != null ? (topBarHeight ?? P8) : 0;
    const radius = Radius.circular(DEF_BORDER_RADIUS);

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Padding(
        padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: (bgColor ?? b2Color).resolve(context),
            borderRadius: BorderRadius.only(
              topLeft: radius,
              topRight: radius,
              bottomLeft: big ? radius : Radius.zero,
              bottomRight: big ? radius : Radius.zero,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    MediaQuery(
                      data: mq.copyWith(
                        padding: mq.padding.copyWith(
                          top: tbHeight,
                          bottom: bbHeight,
                        ),
                      ),
                      child: PrimaryScrollController(controller: scrollController ?? ScrollController(), child: body),
                    ),
                    if (topBar != null)
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: topBar!,
                      ),
                    if (bottomBar != null)
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: bottomBar!,
                      ),
                  ],
                ),
              ),
              if (rightBar != null) rightBar!,
            ],
          ),
        ),
      ),
    );
  }
}
