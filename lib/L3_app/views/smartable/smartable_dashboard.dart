// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../../L1_domain/entities/goals/smartable.dart';
import '../../components/constants.dart';
import '../../components/empty_data_widget.dart';
import '../../components/mt_progress.dart';
import '../../extra/services.dart';
import '../../presenters/number_presenter.dart';
import 'smartable_header.dart';
import 'smartable_list.dart';
import 'smartable_overall_state.dart';

class SmartableDashboard extends StatelessWidget {
  const SmartableDashboard(this.element, {this.breadcrumbs, this.onTap});

  final Smartable element;
  final VoidCallback? onTap;
  final String? breadcrumbs;

  @override
  Widget build(BuildContext context) {
    final hasSubtasks = element.tasksCount > 0;
    return ListView(
      children: [
        SmartableHeader(element: element, breadcrumbs: breadcrumbs),
        if (hasSubtasks) ...[
          SampleProgress(
            ratio: element.doneRatio,
            color: stateColor(element.overallState),
            titleText: loc.smart_subtasks_count(element.tasksCount),
            trailingText: element.doneRatio > 0 ? element.doneRatio.inPercents : '',
          ),
          SizedBox(height: onePadding / 2),
          SmartableList(smartableViewController.subtasks),
          SizedBox(height: onePadding),
        ],
        if (!hasSubtasks && element is Goal)
          EmptyDataWidget(
            title: loc.task_list_empty_title,
            addTitle: loc.task_title_new,
            onAdd: () => smartableViewController.addTask(context),
          ),
      ],
    );
  }
}
