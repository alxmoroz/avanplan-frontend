// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

Widget menuIcon(BuildContext context, {Color? color, double? size}) => Icon(
      Icons.view_headline,
      size: size ?? 32,
      color: (color ?? mainColor).resolve(context),
    );

Widget plusIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.plus_circle,
      size: size ?? 32,
      color: (color ?? mainColor).resolve(context),
    );

Widget editIcon(BuildContext context, {Color? color, double? size}) => Icon(
      Icons.edit,
      size: size ?? 24,
      color: (color ?? mainColor).resolve(context),
    );

Widget calendarIcon(BuildContext context, {Color? color, double? size}) => Icon(
      // CupertinoIcons.calendar,
      Icons.calendar_month,
      size: size ?? 32,
      color: (color ?? mainColor).resolve(context),
    );
