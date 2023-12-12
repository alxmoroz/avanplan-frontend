// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';

import '../../main.dart';
import 'adaptive.dart';
import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'material_wrapper.dart';
import 'toolbar.dart';

Future<T?> showMTDialog<T>(Widget child, {double? maxWidth}) async {
  final ctx = rootKey.currentContext!;
  final size = MediaQuery.sizeOf(ctx);
  final padding = MediaQuery.paddingOf(ctx);

  final isBig = isBigScreen(ctx);

  final constrains = BoxConstraints(
    maxWidth: isBig ? min(size.width - P6, maxWidth ?? SCR_S_WIDTH) : double.infinity,
    maxHeight: isBig ? size.height - padding.top - padding.bottom - P6 : double.infinity,
  );

  final barrierColor = f1Color.withAlpha(220).resolve(ctx);

  return isBig
      ? await showDialog(
          context: ctx,
          barrierColor: barrierColor,
          useRootNavigator: false,
          builder: (_) => UnconstrainedBox(
            child: ConstrainedBox(
              child: material(child),
              constraints: constrains,
            ),
          ),
        )
      : await showModalBottomSheet<T?>(
          context: ctx,
          barrierColor: barrierColor,
          isScrollControlled: true,
          useSafeArea: true,
          constraints: constrains,
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
    this.bgColor,
  });

  final Widget body;

  final Widget? topBar;
  final double? topBarHeight;

  final Widget? bottomBar;
  final double? bottomBarHeight;
  final Color? bottomBarColor;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    final bPadding = bottomPadding(context);
    final mq = MediaQuery.of(context);
    final double bbHeight = bPadding + (bottomBar != null ? (bottomBarHeight ?? P2 + MIN_BTN_HEIGHT) : 0);
    final double tbHeight = topBar != null ? (topBarHeight ?? P8) : 0;
    const radius = Radius.circular(DEF_BORDER_RADIUS);
    final big = isBigScreen(context);
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
          child: Stack(
            children: [
              MediaQuery(
                data: mq.copyWith(
                  padding: mq.padding.copyWith(
                    top: tbHeight,
                    bottom: bbHeight,
                  ),
                ),
                child: body,
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
                  child: MTBottomToolbar(child: bottomBar!, color: bottomBarColor ?? (isBigScreen(context) ? b2Color : navbarDefaultBgColor)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
