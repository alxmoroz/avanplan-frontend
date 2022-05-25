// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/goals/element_of_work.dart';
import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/constants.dart';
import '../../components/empty_data_widget.dart';
import '../../components/mt_progress.dart';
import '../../extra/services.dart';
import '../../presenters/ew_overall_state_presenter.dart';
import '../../presenters/number_presenter.dart';
import 'ew_header.dart';
import 'ew_list.dart';

class EWDashboard extends StatelessWidget {
  const EWDashboard(this.element, {this.breadcrumbs, this.onTap});

  final ElementOfWork element;
  final VoidCallback? onTap;
  final String? breadcrumbs;

  @override
  Widget build(BuildContext context) {
    final hasSubtasks = element.tasksCount > 0;
    return ListView(
      children: [
        EWHeader(element: element, breadcrumbs: breadcrumbs),
        if (hasSubtasks) ...[
          SampleProgress(
            ratio: element.doneRatio,
            color: stateColor(element.overallState),
            titleText: loc.ew_subtasks_count(element.tasksCount),
            trailingText: element.doneRatio > 0 ? element.doneRatio.inPercents : '',
          ),
          SizedBox(height: onePadding / 2),
          EWList(ewViewController.subtasks),
          SizedBox(height: onePadding),
        ],
        if (!hasSubtasks && element is Goal)
          EmptyDataWidget(
            title: loc.task_list_empty_title,
            addTitle: loc.task_title_new,
            onAdd: () => ewViewController.addTask(context),
          ),
      ],
    );
  }
}
