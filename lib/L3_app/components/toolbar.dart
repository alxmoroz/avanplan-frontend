// Copyright (c) 2022. Alexandr Moroz

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'adaptive.dart';
import 'close_dialog_button.dart';
import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'text.dart';

class MTToolBar extends StatelessWidget {
  const MTToolBar({
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

class MTBottomToolbar extends StatelessWidget {
  const MTBottomToolbar({required this.child, required this.color});

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final inner = Padding(
      padding: EdgeInsets.only(top: P2, bottom: bottomPadding(context)),
      child: child,
    );

    return Container(
      color: color.resolve(context),
      child: color.opacity == 1
          ? inner
          : ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: inner,
              ),
            ),
    );
  }
}

Widget _backButton(BuildContext context) => CupertinoNavigationBarBackButton(onPressed: () => Navigator.of(context).pop());

PreferredSize cupertinoNavBar(
  BuildContext context, {
  Widget? leading,
  Widget? middle,
  String? title,
  Widget? trailing,
  Color? bgColor,
  double? height,
  double? paddingBottom,
  double? paddingTop,
  Widget? bottom,
  bool? transitionBetweenRoutes,
  bool isBottom = false,
  bool showCloseButton = false,
}) {
  final innerHeight = height ?? P8;
  final mqPadding = MediaQuery.paddingOf(context);

  paddingTop ??= (isBottom ? P2 : 0);
  final topHeight = paddingTop + (isBottom ? 0 : mqPadding.top);

  paddingBottom = (paddingBottom ?? 0) + (isBottom ? bottomPadding(context) : 0);
  final bottomHeight = paddingBottom;

  return PreferredSize(
    preferredSize: Size.fromHeight(innerHeight),
    child: Container(
      height: topHeight + innerHeight + bottomHeight,
      child: CupertinoNavigationBar(
        transitionBetweenRoutes: !isBottom || transitionBetweenRoutes == true,
        automaticallyImplyLeading: false,
        automaticallyImplyMiddle: false,
        padding: EdgeInsetsDirectional.only(top: paddingTop, bottom: paddingBottom),
        middle: MTToolBar(
          showCloseButton: showCloseButton,
          leading: leading ?? (!isBottom && !showCloseButton && Navigator.of(context).canPop() ? _backButton(context) : null),
          titleText: title,
          middle: middle,
          bottom: bottom,
          trailing: trailing != null ? trailing : null,
          color: Colors.transparent,
        ),
        backgroundColor: bgColor ?? navbarDefaultBgColor,
        border: null,
      ),
    ),
  );
}
