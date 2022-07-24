// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_stats.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/text_widgets.dart';
import '../../presenters/task_overview_presenter.dart';

class TaskStateIndicator extends StatelessWidget {
  const TaskStateIndicator(this.task, {this.inCard = false});

  final Task task;
  final bool inCard;

  @override
  Widget build(BuildContext context) {
    final color = inCard ? darkGreyColor : stateColor(task.state) ?? darkGreyColor;
    final _stateTextTitle = stateTextTitle(task);

    String _stateTextDetails = '';

    if (task.state == TaskState.overdue) {
      _stateTextDetails = overdueStateTextDetails(task.overduePeriod!);
    } else if (task.state == TaskState.risk) {
      _stateTextDetails = riskStateTextDetails(task.etaRiskPeriod!);
    }
    final indicatorText = _stateTextDetails.isNotEmpty ? _stateTextDetails : _stateTextTitle;

    return Row(
      children: [
        stateIcon(context, task, size: onePadding * (inCard ? 1.5 : 2), color: color),
        SizedBox(width: onePadding / 3),
        Expanded(child: inCard ? SmallText(indicatorText, color: color) : NormalText(indicatorText, color: color)),
      ],
    );
  }
}
