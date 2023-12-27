// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'vertical_toolbar_controller.dart';

class VerticalToolbar extends StatelessWidget implements PreferredSizeWidget {
  const VerticalToolbar(this._controller, {required this.child, this.padding, this.rightSide = true});
  final VerticalToolbarController _controller;
  final Widget child;
  final EdgeInsets? padding;
  final bool rightSide;

  @override
  Size get preferredSize => Size.fromWidth(_controller.width);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Observer(
        builder: (_) => Container(
          width: _controller.width,
          padding: MediaQuery.paddingOf(context).copyWith(left: padding?.left, top: padding?.top, right: padding?.right, bottom: padding?.bottom),
          decoration: BoxDecoration(
            color: b3Color.resolve(context),
            borderRadius: BorderRadius.horizontal(
              left: rightSide ? const Radius.circular(DEF_BORDER_RADIUS) : Radius.zero,
              right: rightSide ? Radius.zero : const Radius.circular(DEF_BORDER_RADIUS),
            ),
            boxShadow: [BoxShadow(blurRadius: P, offset: Offset(rightSide ? -1 : 1, 0), color: b1Color.resolve(context))],
          ),
          child: child,
        ),
      ),
      onTap: _controller.toggleWidth,
      // onHorizontalDragUpdate: _controller.swiped,
    );
  }
}
