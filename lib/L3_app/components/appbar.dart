// Copyright (c) 2022. Alexandr Moroz

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'text.dart';

AppBar appBar(
  BuildContext context, {
  Widget? leading,
  Widget? middle,
  Widget? flexibleSpace,
  PreferredSize? bottom,
  String? title,
  Widget? trailing,
  Color? bgColor,
  Border? border,
}) {
  Widget backButton() => CupertinoNavigationBarBackButton(onPressed: () => Navigator.of(context).canPop() ? Navigator.of(context).pop() : null);

  return AppBar(
    leading: leading != null || Navigator.of(context).canPop() ? leading ?? backButton() : null,
    leadingWidth: P10,
    automaticallyImplyLeading: false,
    flexibleSpace: ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: flexibleSpace ?? Container(),
      ),
    ),
    bottom: bottom,
    title: middle != null
        ? middle
        : title != null
            ? BaseText.medium(title, align: TextAlign.center)
            : null,
    backgroundColor: (bgColor ?? navbarDefaultBgColor).resolve(context),
    actions: trailing != null ? [trailing] : [],
  );
}
