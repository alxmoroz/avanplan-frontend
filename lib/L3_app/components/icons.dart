// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

Widget refreshIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.refresh_thin,
      color: (color ?? mainColor).resolve(context),
      size: size ?? 30,
    );

Widget importIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.arrow_down_circle,
      color: (color ?? mainColor).resolve(context),
      size: size ?? 30,
    );

Widget plusIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.plus_circle,
      color: (color ?? mainColor).resolve(context),
      size: size ?? 30,
    );

Widget editIcon(BuildContext context, {Color? color, double? size}) => Icon(
      Icons.edit,
      color: (color ?? mainColor).resolve(context),
      size: size ?? 28,
    );

Widget calendarIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.calendar,
      color: (color ?? mainColor).resolve(context),
      size: size ?? 24,
    );

Widget doneIcon(BuildContext context, bool done, {Color? color, double? size}) => Icon(
      done ? CupertinoIcons.check_mark_circled : CupertinoIcons.circle,
      color: (color ?? mainColor).resolve(context),
      size: size ?? 26,
    );

Widget downCaretIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.chevron_up_chevron_down,
      color: (color ?? mainColor).resolve(context),
      size: size ?? 24,
    );

Widget chevronIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.chevron_right,
      color: (color ?? mainColor).resolve(context),
      size: size ?? 20,
    );

Widget infoIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.info,
      color: (color ?? mainColor).resolve(context),
      size: size ?? 20,
    );

Widget linkIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.link,
      color: (color ?? darkGreyColor).resolve(context),
      size: size ?? 14,
    );

Widget unlinkIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.eye_slash,
      color: (color ?? mainColor).resolve(context),
      size: size ?? 28,
    );

Widget closeIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.clear,
      color: (color ?? mainColor).resolve(context),
      size: size ?? 24,
    );

Widget homeIcon(BuildContext context, {Color? color, double? size}) => Icon(CupertinoIcons.viewfinder_circle, size: size);

Widget tasksIcon(BuildContext context, {Color? color, double? size}) => Icon(CupertinoIcons.text_badge_checkmark, size: size);

Widget menuIcon(BuildContext context, {Color? color, double? size}) => Icon(CupertinoIcons.ellipsis_vertical, size: size);

Widget overdueStateIcon(BuildContext context, {Color? color, double? size}) =>
    Icon(CupertinoIcons.exclamationmark_triangle, color: (color ?? dangerColor).resolve(context), size: size);

Widget riskStateIcon(BuildContext context, {Color? color, double? size}) =>
    Icon(CupertinoIcons.tortoise, color: (color ?? riskyColor).resolve(context), size: size);

Widget okStateIcon(BuildContext context, {Color? color, double? size}) =>
    Icon(CupertinoIcons.rocket, color: (color ?? okColor).resolve(context), size: size);

Widget noInfoStateIcon(BuildContext context, {Color? color, double? size}) =>
    Icon(CupertinoIcons.question_circle, color: (color ?? lightGreyColor).resolve(context), size: size);

Widget redmineIcon() => const Image(image: AssetImage('assets/images/redmine_icon.png'), width: 22, height: 22);
Widget gitlabIcon() => const Image(image: AssetImage('assets/images/gitlab_icon.png'), width: 22, height: 22);
Widget jiraIcon() => const Image(image: AssetImage('assets/images/jira_icon.png'), width: 22, height: 22);
