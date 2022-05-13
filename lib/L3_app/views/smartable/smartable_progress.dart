// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/goals/smartable.dart';
import '../../components/colors.dart';
import '../../components/mt_progress.dart';

// TODO: очень похож на goalsProgress из SmartableDashboardWidget. Нужно его перенести сюда просто (расширить этот)
// TODO: этот виджет используется в одном месте! в карточке только!

class SmartableProgress extends StatelessWidget {
  const SmartableProgress(this.element, {this.body, this.padding});

  final Smartable element;
  final Widget? body;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final _ratio = element.closedRatio ?? 0;
    final _color = element.dueDate != null ? (element.hasRisk ? riskyColor : okColor) : borderColor;

    return MTProgress(
      ratio: _ratio,
      color: _color,
      body: body,
      padding: padding,
    );
  }
}
