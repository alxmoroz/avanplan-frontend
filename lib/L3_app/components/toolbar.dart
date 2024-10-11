// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../navigation/router.dart';
import 'adaptive.dart';
import 'close_dialog_button.dart';
import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'text.dart';

class SubpageTitle extends StatelessWidget {
  const SubpageTitle(this.pageTitle, {super.key, this.parentPageTitle});

  final String? parentPageTitle;
  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: P8,
      padding: const EdgeInsets.symmetric(horizontal: P6),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (parentPageTitle != null)
            SmallText(
              parentPageTitle!,
              align: TextAlign.center,
              maxLines: 1,
              color: f3Color,
              padding: const EdgeInsets.only(bottom: P_2),
            ),
          BaseText.medium(pageTitle, align: TextAlign.center, color: f2Color, maxLines: 1),
        ],
      ),
    );
  }
}

class ToolBar extends StatelessWidget {
  const ToolBar({
    super.key,
    this.pageTitle,
    this.parentPageTitle,
    this.leading,
    this.middle,
    this.bottom,
    this.trailing,
    this.showCloseButton = true,
    this.onClose,
    this.color,
  });
  final String? pageTitle;
  final String? parentPageTitle;
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
              if (middle != null) middle! else if (pageTitle != null) SubpageTitle(pageTitle!, parentPageTitle: parentPageTitle),
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
    this.pageTitle,
    this.parentPageTitle,
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
  final String? pageTitle;
  final String? parentPageTitle;
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
        pageTitle: pageTitle,
        parentPageTitle: parentPageTitle,
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

    final h = (isBottom
            ? bottomInsets > 0
                ? bottomInsets
                : mqPadding.bottom
            : mqPadding.top) +
        preferredSize.height;

    final flat = big || inDialog || isBottom || color != null;
    return Container(
      height: h,
      color: flat ? (color ?? b2Color).resolve(context) : null,
      padding: EdgeInsets.only(top: _pTop, bottom: _pBottom),
      child: flat
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
