// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/goals/smartable.dart';
import '../../components/colors.dart';
import '../../components/mt_progress.dart';

class SmartableProgress extends StatelessWidget {
  const SmartableProgress(this.element, {this.body, this.padding, this.bgColor});

  final Smartable element;
  final Widget? body;
  final EdgeInsets? padding;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    final _color = element.hasRisk
        ? riskyColor
        : element.ok
            ? okColor
            : borderColor;

    return MTProgress(
      ratio: element.doneRatio,
      color: _color,
      bgColor: bgColor,
      body: body,
      padding: padding,
    );
  }
}
