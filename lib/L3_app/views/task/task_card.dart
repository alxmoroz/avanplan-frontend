// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_stats.dart';
import '../../components/constants.dart';
import '../../components/date_string_widget.dart';
import '../../components/icons.dart';
import '../../components/mt_card.dart';
import '../../components/mt_progress.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/number_presenter.dart';
import '../../presenters/task_overview_presenter.dart';
import 'task_state_indicator.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({required this.task, this.onTap, this.expanded = false});

  final Task task;
  final VoidCallback? onTap;
  final bool expanded;

  bool get isClosed => task.closed;

  bool get showDescription => expanded && task.description.isNotEmpty;
  bool get showSubtasks => expanded && task.hasSubtasks;
  bool get showDates => expanded && (task.etaDate != null || task.dueDate != null);

  Widget title(BuildContext context) => H4(
        task.title,
        maxLines: 1,
        decoration: isClosed ? TextDecoration.lineThrough : null,
      );

  Widget header(BuildContext context) => Row(children: [
        Expanded(child: title(context)),
        SizedBox(width: onePadding / 2),
        chevronIcon(context),
      ]);

  Widget description() => LightText(task.description, maxLines: 2);

  Widget subtasksInfo() => Row(children: [
        LightText(loc.task_list_title_count(task.openedLeafTasksCount)),
        const Spacer(),
        if (task.doneRatio > 0) ...[
          SmallText('${loc.common_done} '),
          NormalText(task.doneRatio.inPercents),
        ]
      ]);

  Widget buildDates() => Row(children: [
        DateStringWidget(task.dueDate, titleString: loc.task_due_date_label),
        const Spacer(),
        if (task.openedLeafTasksCount > 0) DateStringWidget(task.etaDate, titleString: loc.task_eta_date_label),
      ]);

  @override
  Widget build(BuildContext context) => MTCard(
        onTap: onTap,
        body: MTProgress(
          ratio: task.doneRatio,
          color: stateColor(task.state),
          body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            header(context),
            if (showDescription) ...[
              SizedBox(height: onePadding / 4),
              description(),
            ],
            if (showSubtasks) ...[
              SizedBox(height: onePadding / 2),
              subtasksInfo(),
            ],
            if (showDates) ...[
              SizedBox(height: onePadding / 2),
              buildDates(),
            ],
            SizedBox(height: onePadding / 2),
            TaskStateIndicator(task, inCard: true),
          ]),
        ),
      );
}
