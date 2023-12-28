// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'adaptive.dart';
import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'material_wrapper.dart';
import 'scrollable.dart';

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
    this.bottomBar,
    this.bottomBarHeight,
    this.bottomBarColor,
    this.rightBar,
    this.bgColor,
    this.scrollController,
    this.scrollOffsetTop,
    this.onScrolled,
  });

  final Widget body;

  final PreferredSizeWidget? topBar;
  final PreferredSizeWidget? rightBar;

  final Widget? bottomBar;
  final double? bottomBarHeight;

  final Color? bottomBarColor;
  final Color? bgColor;

  final ScrollController? scrollController;
  final double? scrollOffsetTop;
  final Function(bool)? onScrolled;

  Widget get _center {
    return Builder(builder: (context) {
      final mq = MediaQuery.of(context);
      final mqPadding = mq.padding;
      final bPadding = isBigScreen ? P2 : defaultBottomPadding(context);
      final double bbHeight = bPadding + (bottomBar != null ? (bottomBarHeight ?? P2 + MIN_BTN_HEIGHT) : 0);

      return Stack(
        children: [
          MediaQuery(
            data: mq.copyWith(
              padding: mqPadding.copyWith(
                top: (topBar?.preferredSize ?? Size.zero).height,
                bottom: bbHeight,
              ),
            ),
            child: scrollOffsetTop != null && scrollController != null
                ? MTScrollable(
                    scrollController: scrollController!,
                    scrollOffsetTop: scrollOffsetTop!,
                    child: body,
                    onScrolled: onScrolled,
                  )
                : body,
          ),
          if (topBar != null) topBar!,
          if (bottomBar != null) Align(alignment: Alignment.bottomCenter, child: bottomBar!),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final mqPadding = mq.padding;
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
              bottomLeft: isBigScreen ? radius : Radius.zero,
              bottomRight: isBigScreen ? radius : Radius.zero,
            ),
          ),
          child: Stack(
            children: [
              rightBar != null
                  ? Observer(builder: (_) {
                      return MediaQuery(
                        data: mq.copyWith(
                          padding: mq.padding.copyWith(
                            right: mqPadding.right + (rightBar?.preferredSize ?? Size.zero).width,
                          ),
                        ),
                        child: _center,
                      );
                    })
                  : _center,
              if (rightBar != null) Align(alignment: Alignment.centerRight, child: rightBar!),
            ],
          ),
        ),
      ),
    );
  }
}
