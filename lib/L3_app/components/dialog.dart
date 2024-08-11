// Copyright (c) 2024. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../extra/router.dart';
import 'adaptive.dart';
import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'material_wrapper.dart';
import 'scrollable.dart';

Color get barrierColor => b0Color.resolve(globalContext).withAlpha(245);

BoxConstraints _dialogConstrains(BuildContext context, double? maxWidth) {
  final size = screenSize(context);
  final big = isBigScreen(context);
  return BoxConstraints(
    maxWidth: big ? min(size.width - P6, maxWidth ?? SCR_S_WIDTH) : double.infinity,
    maxHeight: big ? size.height - screenPadding(context).vertical - P6 : double.infinity,
  );
}

Widget _constrainedDialog(BuildContext context, Widget child, {double? maxWidth}) => UnconstrainedBox(
      child: Container(
        constraints: _dialogConstrains(context, maxWidth),
        child: material(child),
      ),
    );

class MTDialogPage<T> extends Page<T> {
  const MTDialogPage({required this.child, super.name, super.arguments, this.maxWidth, super.key, super.restorationId});

  final Widget child;
  final double? maxWidth;

  @override
  Route<T> createRoute(BuildContext context) => isBigScreen(context)
      ? DialogRoute(
          context: context,
          barrierColor: barrierColor,
          settings: this,
          builder: (_) => _constrainedDialog(context, child, maxWidth: maxWidth),
        )
      : ModalBottomSheetRoute(
          useSafeArea: true,
          constraints: _dialogConstrains(context, maxWidth),
          modalBarrierColor: barrierColor,
          isScrollControlled: true,
          settings: this,
          builder: (_) => child,
        );
}

Future<T?> showMTDialog<T>(Widget child, {double? maxWidth}) async {
  return isBigScreen(globalContext)
      ? await showDialog<T?>(
          context: globalContext,
          barrierColor: barrierColor,
          useRootNavigator: false,
          useSafeArea: true,
          builder: (_) => _constrainedDialog(globalContext, child, maxWidth: maxWidth),
        )
      : await showModalBottomSheet<T?>(
          context: globalContext,
          barrierColor: barrierColor,
          isScrollControlled: true,
          useRootNavigator: false,
          useSafeArea: true,
          constraints: _dialogConstrains(globalContext, maxWidth),
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
                  top: (topBar?.preferredSize.height ?? 0),
                  bottom: (bottomBar?.preferredSize.height ?? 0),
                ),
              ),
              child: SafeArea(
                top: false,
                child: scrollOffsetTop != null && scrollController != null
                    ? MTScrollable(
                        scrollController: scrollController!,
                        scrollOffsetTop: scrollOffsetTop!,
                        onScrolled: onScrolled,
                        bottomShadow: bottomBar != null,
                        child: body,
                      )
                    : body,
              )),
          if (topBar != null) topBar!,
          if (bottomBar != null) Align(alignment: Alignment.bottomCenter, child: bottomBar!),
        ],
      );
    });
  }

  static const _radius = Radius.circular(DEF_BORDER_RADIUS);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final mqPadding = mq.padding;

    final big = isBigScreen(context);

    // final hasKB = mq.viewInsets.bottom != 0;
    final showRightBar = rightBar != null; // && !hasKB;

    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Padding(
        padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: (bgColor ?? b2Color).resolve(context),
            borderRadius: BorderRadius.only(
              topLeft: _radius,
              topRight: _radius,
              bottomLeft: big ? _radius : Radius.zero,
              bottomRight: big ? _radius : Radius.zero,
            ),
          ),
          child: Stack(
            children: [
              showRightBar
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
              if (showRightBar) Align(alignment: Alignment.centerRight, child: rightBar!),
            ],
          ),
        ),
      ),
    );
  }
}
