// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'colors.dart';
import 'constants.dart';
import 'painters.dart';

Widget refreshIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.refresh_thick,
      color: (color ?? mainColor).resolve(context),
      size: size ?? 30,
    );

Widget connectingIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.dot_radiowaves_left_right,
      color: (color ?? darkGreyColor).resolve(context),
      size: size ?? onePadding,
    );

Widget importIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.arrow_down_to_line,
      color: (color ?? mainColor).resolve(context),
      size: size ?? onePadding * 1.7,
    );

Widget wsIcon(BuildContext context, {Color? color, double? size}) => FaIcon(
      FontAwesomeIcons.houseUser,
      color: (color ?? darkGreyColor).resolve(context),
      size: size ?? onePadding * 1.45,
    );

Widget plusIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.plus,
      color: (color ?? mainColor).resolve(context),
      size: size ?? onePadding * 2,
    );

Widget editIcon(BuildContext context, {Color? color, double? size}) => Icon(
      Icons.edit,
      color: (color ?? mainColor).resolve(context),
      size: size ?? onePadding * 2,
    );

Widget calendarIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.calendar,
      color: (color ?? mainColor).resolve(context),
      size: size ?? onePadding * 2,
    );

Widget doneIcon(BuildContext context, bool done, {Color? color, double? size}) => Icon(
      done ? CupertinoIcons.check_mark_circled : CupertinoIcons.circle,
      color: (color ?? mainColor).resolve(context),
      size: size ?? onePadding * 2,
    );

Widget dropdownCaretIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.chevron_up_chevron_down,
      color: (color ?? mainColor).resolve(context),
      size: size ?? onePadding * 2,
    );

Widget chevronIcon(BuildContext context, {Color? color, double? size}) => FaIcon(
      FontAwesomeIcons.chevronRight,
      color: (color ?? mainColor).resolve(context),
      size: size ?? onePadding * 1.2,
    );

Widget linkIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.link,
      color: (color ?? darkGreyColor).resolve(context),
      size: size ?? onePadding * 1.4,
    );

Widget linkOutIcon(BuildContext context, {Color? color, double? size}) => FaIcon(
      FontAwesomeIcons.arrowUpRightFromSquare,
      color: (color ?? mainColor).resolve(context),
      size: size ?? onePadding,
    );

Widget unlinkIcon(BuildContext context, {Color? color, double? size}) => FaIcon(
      FontAwesomeIcons.linkSlash,
      color: (color ?? warningColor).resolve(context),
      size: size ?? onePadding * 1.4,
    );

Widget eyeSlashIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.eye_slash,
      color: (color ?? dangerColor).resolve(context),
      size: size ?? onePadding * 2,
    );

Widget eyeIcon(BuildContext context, {bool open = true, Color? color, double? size}) => Icon(
      open ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
      color: (color ?? darkGreyColor).resolve(context),
      size: size ?? onePadding * 2,
    );

Widget closeIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.clear,
      color: (color ?? mainColor).resolve(context),
      size: size ?? onePadding * 2,
    );

Widget logoutIcon(BuildContext context, {Color? color, double? size}) => FaIcon(
      FontAwesomeIcons.arrowRightFromBracket,
      color: (color ?? mainColor).resolve(context),
      size: size ?? onePadding * 1.5,
    );

Widget menuIcon(BuildContext context, {double? size}) => Icon(
      CupertinoIcons.ellipsis_vertical,
      color: mainColor.resolve(context),
      size: size,
    );

Widget overdueStateIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.exclamationmark_triangle,
      color: (color ?? dangerColor).resolve(context),
      size: size,
    );

Widget riskStateIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.tortoise,
      color: (color ?? warningColor).resolve(context),
      size: size,
    );

Widget okStateIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.rocket,
      color: (color ?? greenColor).resolve(context),
      size: size,
    );

Widget noInfoStateIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.question_circle,
      color: (color ?? lightGreyColor).resolve(context),
      size: size,
    );

Widget openedStateIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.pause_circle,
      color: (color ?? lightGreyColor).resolve(context),
      size: size,
    );

Widget backlogStateIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.archivebox,
      color: (color ?? lightGreyColor).resolve(context),
      size: size,
    );

Widget caretIcon(BuildContext context, {required Size size, Color? color, bool up = false}) => RotatedBox(
      quarterTurns: up ? 0 : 2,
      child: CustomPaint(
        painter: TrianglePainter(color: (color ?? darkGreyColor).resolve(context)),
        child: Container(height: size.height, width: size.width),
      ),
    );

Widget todayIcon({Color? color, double? size}) => Icon(CupertinoIcons.placemark, size: size);

Widget mailIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.envelope,
      color: (color ?? darkGreyColor).resolve(context),
      size: size ?? onePadding * 2,
    );
Widget privacyIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.lock_shield,
      color: (color ?? darkGreyColor).resolve(context),
      size: size ?? onePadding * 2,
    );

double get _sourceIconSize => onePadding * 2;

Widget redmineIcon() => Image.asset('assets/images/redmine_icon.png', width: _sourceIconSize, height: _sourceIconSize);
Widget gitlabIcon() => Image.asset('assets/images/gitlab_icon.png', width: _sourceIconSize, height: _sourceIconSize);
Widget jiraIcon() => Image.asset('assets/images/jira_icon.png', width: _sourceIconSize, height: _sourceIconSize);
Widget googleIcon({double? size}) => Image.asset('assets/images/google_icon.png', width: size, height: size);
Widget gerculesIcon({double? size}) => Image.asset('assets/images/gercules_icon.png', width: size, height: size);
