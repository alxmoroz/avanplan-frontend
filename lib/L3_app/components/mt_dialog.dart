// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';

import '../../main.dart';
import 'colors.dart';
import 'constants.dart';
import 'material_wrapper.dart';
import 'mt_toolbar.dart';

bool _bigScreen(BuildContext context) {
  final mq = MediaQuery.of(context);
  final mqH = mq.size.height;
  final mqW = mq.size.width;
  return mqH > SCR_M_HEIGHT && mqW > SCR_M_WIDTH;
}

Future<T?> showMTDialog<T>(Widget child) async {
  final ctx = rootKey.currentContext!;
  final mq = MediaQuery.of(ctx);
  final mqH = mq.size.height;
  final mqW = mq.size.width;

  final constrains = BoxConstraints(
    maxWidth: mqW > SCR_L_WIDTH ? SCR_L_WIDTH : SCR_M_WIDTH,
    maxHeight: mqH > SCR_S_HEIGHT ? mqH - mq.padding.top - P2 : double.infinity,
  );

  final barrierColor = darkGreyColor.withAlpha(230).resolve(ctx);

  return _bigScreen(ctx)
      ? await showDialog(
          context: ctx,
          barrierColor: barrierColor,
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
    const radius = Radius.circular(DEF_BORDER_RADIUS);
    final big = _bigScreen(context);
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Padding(
        padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: backgroundColor.resolve(context),
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
    );
  }
}
