// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

Widget plusIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.plus_circle,
      size: size ?? 28,
      color: (color ?? mainColor).resolve(context),
    );

Widget editIcon(BuildContext context, {Color? color, double? size}) => Icon(
      Icons.edit,
      size: size ?? 20,
      color: (color ?? mainColor).resolve(context),
    );

// Widget deleteIcon(BuildContext context, {Color? color, double? size}) => Icon(
//       CupertinoIcons.delete,
//       size: size ?? 24,
//       color: (color ?? dangerColor).resolve(context),
//     );

Widget calendarIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.calendar,
      size: size ?? 24,
      color: (color ?? mainColor).resolve(context),
    );

Widget doneIcon(BuildContext context, bool done, {Color? color, double? size}) => Icon(
      done ? CupertinoIcons.check_mark_circled : CupertinoIcons.circle,
      size: size ?? 24,
      color: (color ?? mainColor).resolve(context),
    );

Widget downCaretIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.chevron_up_chevron_down,
      size: size ?? 24,
      color: (color ?? mainColor).resolve(context),
    );

Widget chevronIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.chevron_right,
      size: size ?? 20,
      color: (color ?? mainColor).resolve(context),
    );

Widget infoIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.info,
      size: size ?? 20,
      color: (color ?? mainColor).resolve(context),
    );

Widget linkIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.link,
      size: size ?? 14,
      color: (color ?? mainColor).resolve(context),
    );

Widget closeIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.clear,
      size: size ?? 24,
      color: (color ?? mainColor).resolve(context),
    );

Widget homeIcon(BuildContext context, {Color? color, double? size}) => Icon(
      // CupertinoIcons.viewfinder,
      // CupertinoIcons.scope,
      CupertinoIcons.viewfinder_circle,
      size: size,
    );

Widget goalsIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.text_badge_checkmark,
      size: size,
    );

Widget menuIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.ellipsis_vertical,
      size: size,
    );

Widget overdueIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.exclamationmark_triangle,
      color: (color ?? warningColor).resolve(context),
      size: size,
    );

Widget badPaceIcon(BuildContext context, {Color? color, double? size}) =>
    Icon(CupertinoIcons.tortoise, size: size, color: (color ?? riskyColor).resolve(context));

Widget goodPaceIcon(BuildContext context, {Color? color, double? size}) =>
    Icon(CupertinoIcons.rocket, size: size, color: (color ?? okColor).resolve(context));

Widget noInfoIcon(BuildContext context, {Color? color, double? size}) =>
    Icon(CupertinoIcons.question, size: size, color: (color ?? borderColor).resolve(context));
