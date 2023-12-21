// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';

import '../../main.dart';
import 'adaptive.dart';
import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'material_wrapper.dart';

BuildContext get _globalCtx => rootKey.currentContext!;
Color get barrierColor => b0Color.resolve(_globalCtx).withAlpha(220);

final _isBig = isBigScreen(_globalCtx);
Size get _size => MediaQuery.sizeOf(_globalCtx);
EdgeInsets get _padding => MediaQuery.paddingOf(_globalCtx);

BoxConstraints _constrains(double? maxWidth) => BoxConstraints(
      maxWidth: _isBig ? min(_size.width - P6 - (showSideMenu(_globalCtx) ? P12 + P : 0), maxWidth ?? SCR_S_WIDTH) : double.infinity,
      maxHeight: _isBig ? _size.height - _padding.top - _padding.bottom - P6 : double.infinity,
    );

class MTAdaptiveDialog extends StatelessWidget {
  const MTAdaptiveDialog(this._child, {this.maxWidth});
  final Widget _child;
  final double? maxWidth;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _isBig
          ? UnconstrainedBox(
              // TODO: проверить Container с constraints вместо UnconstrainedBox
              child: ConstrainedBox(
                constraints: _constrains(maxWidth),
                child: material(_child),
              ),
            )
          : _child,
    );
  }
}

Future<T?> showMTDialog<T>(Widget child, {double? maxWidth}) async {
  return _isBig
      ? await showDialog<T?>(
          context: _globalCtx,
          barrierColor: barrierColor,
          useRootNavigator: false,
          useSafeArea: false,
          builder: (_) => MTAdaptiveDialog(child, maxWidth: maxWidth),
        )
      : await showModalBottomSheet<T?>(
          context: _globalCtx,
          barrierColor: barrierColor,
          isScrollControlled: true,
          useSafeArea: false,
          constraints: _constrains(maxWidth),
          builder: (_) => MTAdaptiveDialog(child),
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
                  child: bottomBar!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
