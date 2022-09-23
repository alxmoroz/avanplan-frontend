// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:gercules/L3_app/components/text_widgets.dart';
import 'package:gercules/L3_app/presenters/task_state_presenter.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_ext_state.dart';
import '../../../components/constants.dart';
import '../task_related_widgets/task_overview_advices.dart';
import '../task_related_widgets/task_overview_warnings.dart';
import '../task_view_controller.dart';
import 'task_time_chart.dart';

enum IndicatorPlacement { workspace, other }

class TaskOverview extends StatelessWidget {
  const TaskOverview(this.controller);
  final TaskViewController controller;
  Task get task => controller.task;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: EdgeInsets.all(onePadding),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            if (task.showState) H4(task.stateTitle, color: task.stateColor),
            if (task.showTimeChart) TaskTimeChart(task),
          ]),
        ),
        if (task.overdueSubtasks.isNotEmpty || task.riskySubtasks.isNotEmpty) ...[
          if (task.subtasksStateTitle != task.stateTitle)
            NormalText(task.subtasksStateTitle, color: task.stateColor, padding: EdgeInsets.symmetric(horizontal: onePadding)),
          TaskOverviewWarnings(task),
        ] else
          TaskOverviewAdvices(task),
      ],
    );
  }
}
