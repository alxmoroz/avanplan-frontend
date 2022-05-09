// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/goals/smartable.dart';
import '../../components/colors.dart';
import '../../components/progress.dart';

class SmartableProgressWidget extends StatelessWidget {
  const SmartableProgressWidget(this.element, this.body);

  final Smartable element;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final _ratio = element.closedRatio ?? 0;
    final _color = element.dueDate != null ? (element.hasRisk ? riskyColor : okColor) : borderColor;

    return MTProgress(
      ratio: _ratio,
      color: _color,
      body: body,
    );
  }
}
