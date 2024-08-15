// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../extra/router.dart';
import 'adaptive.dart';
import 'close_dialog_button.dart';
import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'text.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({
    super.key,
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

Widget get _backButton => CupertinoNavigationBarBackButton(onPressed: router.pop);

class MTAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MTAppBar({
    super.key,
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
    this.inDialog = false,
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
  final bool inDialog;
  final bool showCloseButton;
  final VoidCallback? onClose;

  double get _pTop => padding?.top ?? 0;
  double get _innerHeight => innerHeight ?? P8;
  double get _pBottom => padding?.bottom ?? 0;

  @override
  Size get preferredSize => Size.fromHeight(_pTop + _innerHeight + _pBottom);

  Widget get _toolbar => ToolBar(
        showCloseButton: showCloseButton,
        onClose: onClose,
        leading: leading ?? (!isBottom && !showCloseButton && router.canPop() ? _backButton : null),
        titleText: title,
        middle: middle,
        bottom: bottom,
        trailing: trailing,
        color: Colors.transparent,
      );

  @override
  Widget build(BuildContext context) {
    final mqPadding = MediaQuery.paddingOf(context);
    final big = isBigScreen(context);

    final bottomInsets = isBottom && !inDialog ? MediaQuery.viewInsetsOf(context).bottom : 0.0;
    final rColor = (color ?? b2Color).resolve(context);

    final h = (isBottom
            ? bottomInsets > 0
                ? bottomInsets
                : mqPadding.bottom
            : mqPadding.top) +
        preferredSize.height;

    return Container(
      height: h,
      color: rColor,
      padding: EdgeInsets.only(top: _pTop, bottom: _pBottom),
      child: big || isBottom
          ? SafeArea(
              top: !isBottom,
              bottom: isBottom,
              child: _toolbar,
            )
          : CupertinoNavigationBar(
              automaticallyImplyLeading: false,
              automaticallyImplyMiddle: false,
              padding: EdgeInsetsDirectional.only(top: _pTop, bottom: _pBottom, start: 0, end: 0),
              leading: _toolbar,
              backgroundColor: color ?? navbarDefaultBgColor,
              border: null,
            ),
    );
  }
}
