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
    this.bottom,
    this.color,
    this.innerHeight,
    this.padding,
    this.isBottom = false,
    this.showCloseButton = false,
    this.onClose,
  });

  final Widget? leading;
  final Widget? middle;
  final String? title;
  final Widget? trailing;
  final Color? color;
  final double? innerHeight;
  final EdgeInsets? padding;
  final Widget? bottom;
  final bool isBottom;
  final bool showCloseButton;
  final VoidCallback? onClose;

  double get _pTop => padding?.top ?? 0;
  double get _innerHeight => innerHeight ?? P8;
  double get _pBottom => padding?.bottom ?? 0;

  @override
  Size get preferredSize => Size.fromHeight(_pTop + _innerHeight + _pBottom);

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

    return Container(
      height: (isBottom ? mqPadding.bottom : mqPadding.top) + preferredSize.height,
      color: color?.resolve(context),
      child: isBigScreen(context) || isBottom
          ? SafeArea(
              top: false,
              bottom: false,
              child: Container(
                padding: EdgeInsets.only(top: _pTop, bottom: _pBottom),
                child: _toolbar(context),
                color: (color ?? b2Color).resolve(context),
              ),
            )
          : CupertinoNavigationBar(
              automaticallyImplyLeading: false,
              automaticallyImplyMiddle: false,
              padding: EdgeInsetsDirectional.only(top: _pTop, bottom: _pBottom, start: 0, end: 0),
              leading: _toolbar(context),
              backgroundColor: color ?? navbarDefaultBgColor,
              border: null,
            ),
    );
  }
}
