// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'button.dart';
import 'circle.dart';
import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'icons.dart';
import 'vertical_toolbar_controller.dart';

class VerticalToolbar extends StatelessWidget implements PreferredSizeWidget {
  const VerticalToolbar(this._controller, {super.key, required this.child, this.rightSide = true});
  final VerticalToolbarController _controller;
  final Widget child;
  final bool rightSide;

  @override
  Size get preferredSize => Size.fromWidth(_controller.width);
  static const _tgBtnSize = P12;
  static const _btnDx = P;
  static const _btnBorderWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    final mqPadding = MediaQuery.paddingOf(context);
    final paneWidth = (rightSide ? mqPadding.right : mqPadding.left) + preferredSize.width;

    return Observer(builder: (_) {
      /// Тень для кнопки сворачивания / разворачивания
      final tgBtnShadow = Positioned(
        left: rightSide ? -_btnBorderWidth : null,
        right: rightSide ? null : -_btnBorderWidth,
        child: MTCircle(
          color: b3Color,
          size: _tgBtnSize,
          boxShadow: [BoxShadow(blurRadius: P_2, offset: Offset(rightSide ? -1 : 1, 0), color: b1Color.resolve(context))],
        ),
      );

      /// Панель инструментов с тенью
      final panel = Container(
        width: paneWidth,
        decoration: BoxDecoration(
          color: b3Color.resolve(context),
          borderRadius: BorderRadius.horizontal(
            left: rightSide ? const Radius.circular(DEF_BORDER_RADIUS) : Radius.zero,
            right: rightSide ? Radius.zero : const Radius.circular(DEF_BORDER_RADIUS),
          ),
          boxShadow: [BoxShadow(blurRadius: P, offset: Offset(rightSide ? -1 : 1, 0), color: b1Color.resolve(context))],
        ),
        child: SafeArea(
          left: !rightSide,
          right: rightSide,
          child: child,
        ),
      );

      /// Кнопка для сворачивания / разворачивания
      final tgBtn = Container(
        alignment: rightSide ? Alignment.centerLeft : Alignment.centerRight,
        width: paneWidth + _btnDx,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const MTCircle(size: _tgBtnSize, color: b3Color),
            MTButton(
              constrained: false,
              middle: MTCircle(
                size: _tgBtnSize,
                color: b3Color,
                child: Container(
                  alignment: rightSide ? Alignment.centerLeft : Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: _btnDx),
                  child: ChevronCaretIcon(
                    size: const Size(P2 + P_2, P),
                    left: rightSide ? _controller.compact : !_controller.compact,
                  ),
                ),
              ),
              onTap: _controller.toggleWidth,
            ),
          ],
        ),
      );

      return Stack(
        clipBehavior: Clip.none,
        alignment: rightSide ? Alignment.centerRight : Alignment.centerLeft,
        children: [
          tgBtnShadow,
          panel,
          tgBtn,
        ],
      );
    });
  }
}
