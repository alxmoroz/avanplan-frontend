// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';

import '../../main.dart';
import 'colors.dart';
import 'constants.dart';
import 'mt_adaptive.dart';
import 'mt_toolbar.dart';

Future<T?> showMTBottomSheet<T>(Widget child) async {
  final ctx = rootKey.currentContext!;
  final mq = MediaQuery.of(ctx);
  final mqH = mq.size.height;
  final mqW = mq.size.width;

  final bigScreen = mqH > SCR_M_HEIGHT && mqW > SCR_M_WIDTH;

  return bigScreen
      ? await showDialog(
          context: ctx,
          builder: (_) {
            final body = Center(child: child);
            return mqW > SCR_L_WIDTH ? MTAdaptive.L(body) : MTAdaptive(child: body);
          },
        )
      : await showModalBottomSheet<T?>(
          context: ctx,
          isScrollControlled: true,
          constraints: BoxConstraints(
            maxWidth: SCR_L_WIDTH,
            maxHeight: mqH > SCR_S_HEIGHT ? mqH - mq.padding.top - P : double.infinity,
          ),
          builder: (_) => child,
        );
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
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Padding(
        padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: backgroundColor.resolve(context),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(DEF_BORDER_RADIUS),
              topRight: Radius.circular(DEF_BORDER_RADIUS),
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
