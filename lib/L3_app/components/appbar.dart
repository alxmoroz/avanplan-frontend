// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'text.dart';

Widget _backButton(BuildContext context) =>
    CupertinoNavigationBarBackButton(onPressed: () => Navigator.of(context).canPop() ? Navigator.of(context).pop() : null);

CupertinoNavigationBar cupertinoNavBar(
  BuildContext context, {
  Widget? leading,
  Widget? middle,
  String? title,
  Widget? trailing,
  Color? bgColor,
}) =>
    CupertinoNavigationBar(
      padding: EdgeInsetsDirectional.zero,
      leading: leading != null || Navigator.of(context).canPop() ? leading ?? _backButton(context) : null,
      middle: middle != null
          ? middle
          : title != null
              ? BaseText.medium(title, align: TextAlign.center)
              : null,
      trailing: trailing != null ? trailing : null,
      backgroundColor: bgColor ?? navbarDefaultBgColor,
    );

class MTAppBar extends AppBar {
  MTAppBar(
    BuildContext context, {
    Widget? leading,
    Widget? middle,
    // Widget? flexibleSpace,
    PreferredSize? bottom,
    String? title,
    Widget? trailing,
    Color? bgColor,
    double? leadingWidth,
  }) : super(
          leading: leading != null || Navigator.of(context).canPop() ? leading ?? _backButton(context) : null,
          leadingWidth: leadingWidth ?? P8,
          automaticallyImplyLeading: false,
          // flexibleSpace: ClipRect(
          //   child: BackdropFilter(
          //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          //     child: flexibleSpace ?? Container(),
          //   ),
          // ),
          bottom: bottom,
          centerTitle: true,
          title: middle != null
              ? middle
              : title != null
                  ? BaseText.medium(title, align: TextAlign.center)
                  : null,
          backgroundColor: (bgColor ?? navbarDefaultBgColor).resolve(context),
          actions: trailing != null ? [trailing] : [],
        );
}
