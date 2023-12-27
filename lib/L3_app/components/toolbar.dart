// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'adaptive.dart';
import 'close_dialog_button.dart';
import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'text.dart';

class _ToolBar extends StatelessWidget {
  const _ToolBar({
    this.titleText,
    this.leading,
    this.middle,
    this.bottom,
    this.trailing,
    this.showCloseButton = true,
    this.onClose,
    this.color,
  });
  final String? titleText;
  final Widget? leading;
  final Widget? middle;
  final Widget? bottom;
  final Widget? trailing;
  final bool showCloseButton;
  final VoidCallback? onClose;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (color ?? b2Color).resolve(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              if (middle != null || titleText != null) middle ?? BaseText.medium(titleText!, align: TextAlign.center, maxLines: 1),
              Row(children: [
                if (leading != null || showCloseButton) leading ?? MTCloseDialogButton(onTap: onClose),
                const Spacer(),
                if (trailing != null) trailing!,
              ]),
            ],
          ),
          if (bottom != null) bottom!,
        ],
      ),
    );
  }
}

Widget _backButton(BuildContext context) => CupertinoNavigationBarBackButton(onPressed: () => Navigator.of(context).pop());

class MTAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MTAppBar({
    this.leading,
    this.middle,
    this.title,
    this.trailing,
    this.bgColor,
    this.height,
    this.paddingBottom,
    this.paddingTop,
    this.bottom,
    this.transitionBetweenRoutes,
    this.isBottom = false,
    this.showCloseButton = false,
    this.onClose,
  });

  final Widget? leading;
  final Widget? middle;
  final String? title;
  final Widget? trailing;
  final Color? bgColor;
  final double? height;
  final double? paddingBottom;
  final double? paddingTop;
  final Widget? bottom;
  final bool? transitionBetweenRoutes;
  final bool isBottom;
  final bool showCloseButton;
  final VoidCallback? onClose;

  double get _innerHeight => height ?? P8;

  @override
  Size get preferredSize => Size.fromHeight(_innerHeight);

  Widget _toolbar(BuildContext context) => _ToolBar(
        showCloseButton: showCloseButton,
        onClose: onClose,
        leading: leading ?? (!isBottom && !showCloseButton && Navigator.of(context).canPop() ? _backButton(context) : null),
        titleText: title,
        middle: middle,
        bottom: bottom,
        trailing: trailing != null ? trailing : null,
        color: Colors.transparent,
      );

  @override
  Widget build(BuildContext context) {
    final mqPadding = MediaQuery.paddingOf(context);

    final pTop = paddingTop ?? (isBottom ? P2 : 0);
    final topHeight = pTop + (isBottom ? 0 : mqPadding.top);

    final pBottom = paddingBottom ?? (isBottom ? defaultBottomPadding(context) : 0);
    final bottomHeight = pBottom;

    return Container(
      height: topHeight + _innerHeight + bottomHeight,
      child: isBigScreen
          ? Container(
              padding: mqPadding.copyWith(top: topHeight, bottom: bottomHeight),
              child: _toolbar(context),
              color: (bgColor ?? b2Color).resolve(context),
            )
          : CupertinoNavigationBar(
              transitionBetweenRoutes: !isBottom || transitionBetweenRoutes == true,
              automaticallyImplyLeading: false,
              automaticallyImplyMiddle: false,
              padding: EdgeInsetsDirectional.only(top: pTop, bottom: pBottom, start: 0, end: 0),
              leading: _toolbar(context),
              backgroundColor: bgColor ?? navbarDefaultBgColor,
              border: null,
            ),
    );
  }
}
