// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';

import '../../main.dart';
import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'material_wrapper.dart';
import 'toolbar.dart';

bool _bigScreen(BuildContext context) {
  final mq = MediaQuery.of(context);
  final mqH = mq.size.height;
  final mqW = mq.size.width;
  return mqH > SCR_S_HEIGHT && mqW > SCR_M_WIDTH;
}

Future<T?> showMTDialog<T>(Widget child) async {
  final ctx = rootKey.currentContext!;
  final mq = MediaQuery.of(ctx);
  final mqH = mq.size.height;
  final mqW = mq.size.width;

  final constrains = BoxConstraints(
    // minHeight: mqH / 4,
    maxWidth: mqW > SCR_L_WIDTH ? SCR_L_WIDTH : SCR_M_WIDTH,
    maxHeight: mqH > SCR_XS_HEIGHT ? mqH - mq.padding.top - P2 : double.infinity,
  );

  final barrierColor = f1Color.withAlpha(220).resolve(ctx);

  return _bigScreen(ctx)
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
          constraints: constrains,
          builder: (_) => child,
        );
}

class MTDialog extends StatelessWidget {
  const MTDialog({
    required this.body,
    this.topBar,
    this.topBarHeight,
    this.topBarColor,
    this.bottomBar,
    this.bottomBarHeight,
    this.bottomBarColor,
    this.bgColor,
  });

  final Widget body;

  final Widget? topBar;
  final double? topBarHeight;
  final Color? topBarColor;

  final Widget? bottomBar;
  final double? bottomBarHeight;
  final Color? bottomBarColor;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final double bbHeight = bottomBar != null ? (bottomBarHeight ?? P8 + MIN_BTN_HEIGHT) : max(P6, mq.padding.bottom);
    final double tbHeight = topBar != null ? (topBarHeight ?? P8) : 0;
    const radius = Radius.circular(DEF_BORDER_RADIUS);
    final big = _bigScreen(context);
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
                  child: MTToolbar.top(child: topBar!, color: topBarColor ?? b2Color),
                ),
              if (bottomBar != null)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: MTToolbar(child: bottomBar!, color: bottomBarColor ?? navbarDefaultBgColor),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
