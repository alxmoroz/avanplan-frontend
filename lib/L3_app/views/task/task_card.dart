// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/constants.dart';
import '../../components/date_string_widget.dart';
import '../../components/icons.dart';
import '../../components/mt_card.dart';
import '../../components/mt_progress.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/ew_overview_presenter.dart';
import '../../presenters/number_presenter.dart';
import 'ew_state_indicator.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({required this.task, this.onTap, this.expanded = false});

  final Task task;
  final VoidCallback? onTap;
  final bool expanded;

  bool get isClosed => task.closed;

  bool get showDescription => expanded && task.description.isNotEmpty;
  bool get showSubEW => expanded && task.leafTasksCount > 0;
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

  Widget subEWInfo() => Row(children: [
        LightText(loc.ew_subtasks_count(task.leafTasksCount)),
        const Spacer(),
        if (task.doneRatio > 0) ...[
          SmallText('${loc.common_mark_done_btn_title} '),
          NormalText(task.doneRatio.inPercents),
        ]
      ]);

  Widget buildDates() => Row(children: [
        DateStringWidget(task.dueDate, titleString: loc.ew_due_date_label),
        const Spacer(),
        if (task.leftTasksCount > 0) DateStringWidget(task.etaDate, titleString: loc.ew_eta_date_label),
      ]);

  @override
  Widget build(BuildContext context) => MTCard(
        onTap: onTap,
        body: MTProgress(
          ratio: task.doneRatio,
          color: stateColor(task.overallState),
          body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            header(context),
            if (showDescription) ...[
              SizedBox(height: onePadding / 4),
              description(),
            ],
            if (showSubEW) ...[
              SizedBox(height: onePadding / 2),
              subEWInfo(),
            ],
            if (showDates) ...[
              SizedBox(height: onePadding / 2),
              buildDates(),
            ],
            SizedBox(height: onePadding / 2),
            EWStateIndicator(task, inCard: true),
          ]),
        ),
      );
}
