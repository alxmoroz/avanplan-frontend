// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'text.dart';

MediaQuery mQuery(Widget child, BuildContext ctx) => MediaQuery(
      data: MediaQuery.of(ctx),
      child: child,
    );

CupertinoNavigationBar navBar(
  BuildContext context, {
  Widget? leading,
  Widget? middle,
  String? title,
  Widget? trailing,
  Color? bgColor,
  Border? border,
}) {
  Widget backButton() => CupertinoNavigationBarBackButton(onPressed: () => Navigator.of(context).canPop() ? Navigator.of(context).pop() : null);

  return CupertinoNavigationBar(
    leading: leading != null || Navigator.of(context).canPop() ? mQuery(leading ?? backButton(), context) : null,
    middle: middle != null
        ? mQuery(middle, context)
        : title != null
            ? mQuery(BaseText.medium(title, align: TextAlign.center), context)
            : null,
    trailing: trailing != null ? mQuery(trailing, context) : null,
    padding: const EdgeInsetsDirectional.only(start: 0),
    backgroundColor: bgColor ?? navbarDefaultBgColor,
    border: border,
  );
}
