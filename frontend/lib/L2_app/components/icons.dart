// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

Widget menuIcon(BuildContext context, {Color? color, double? size}) => Icon(
      Icons.view_headline,
      size: size ?? 32,
      color: (color ?? mainColor).resolve(context),
    );
