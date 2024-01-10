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

BoxConstraints dialogConstrains(BuildContext context, double? maxWidth) {
  final size = screenSize(context);
  final big = isBigScreen(context);
  return BoxConstraints(
    maxWidth: big ? min(size.width - P6, maxWidth ?? SCR_S_WIDTH) : double.infinity,
    maxHeight: big ? size.height - screenPadding(context).vertical - P6 : double.infinity,
  );
}

Widget constrainedDialog(BuildContext context, Widget child, {double? maxWidth}) => UnconstrainedBox(
      child: Container(
        constraints: dialogConstrains(context, maxWidth),
        child: material(child),
      ),
    );

Future<T?> showMTDialog<T>(Widget child, {double? maxWidth}) async {
  return isBigScreen(globalContext)
      ? await showDialog<T?>(
          context: globalContext,
          barrierColor: barrierColor,
          useRootNavigator: false,
          useSafeArea: true,
          builder: (_) => constrainedDialog(globalContext, child, maxWidth: maxWidth),
        )
      : await showModalBottomSheet<T?>(
          context: globalContext,
          barrierColor: barrierColor,
          isScrollControlled: true,
          useRootNavigator: false,
          useSafeArea: true,
          constraints: dialogConstrains(globalContext, maxWidth),
          builder: (_) => child,
        );
}

class MTDialog extends StatelessWidget {
  const MTDialog({
    super.key,
    required this.body,
    this.topBar,
    this.bottomBar,
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
  final PreferredSizeWidget? bottomBar;

  final Color? bottomBarColor;
  final Color? bgColor;

  final ScrollController? scrollController;
  final double? scrollOffsetTop;
  final Function(bool)? onScrolled;

  Widget get _center {
    return Builder(builder: (context) {
      final mq = MediaQuery.of(context);
      final mqPadding = mq.padding;
      return Stack(
        children: [
          MediaQuery(
            data: mq.copyWith(
              padding: mqPadding.copyWith(
                top: (topBar?.preferredSize ?? Size.zero).height,
                bottom: (bottomBar?.preferredSize ?? Size.zero).height + max(isBigScreen(context) ? 0 : mqPadding.bottom, P3),
              ),
            ),
            child: scrollOffsetTop != null && scrollController != null
                ? MTScrollable(
                    scrollController: scrollController!,
                    scrollOffsetTop: scrollOffsetTop!,
                    onScrolled: onScrolled,
                    child: body,
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
