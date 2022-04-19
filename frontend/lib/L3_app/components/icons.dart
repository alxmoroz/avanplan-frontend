// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

Widget menuIcon(BuildContext context, {Color? color, double? size}) => Icon(
      Icons.view_headline,
      size: size ?? 30,
      color: (color ?? mainColor).resolve(context),
    );

Widget plusIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.plus_circle,
      size: size ?? 30,
      color: (color ?? mainColor).resolve(context),
    );

Widget editIcon(BuildContext context, {Color? color, double? size}) => Icon(
      Icons.edit,
      size: size ?? 20,
      color: (color ?? mainColor).resolve(context),
    );

Widget deleteIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.delete,
      size: size ?? 24,
      color: (color ?? dangerColor).resolve(context),
    );

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
      CupertinoIcons.clear_circled,
      size: size ?? 30,
      color: (color ?? mainColor).resolve(context),
    );
