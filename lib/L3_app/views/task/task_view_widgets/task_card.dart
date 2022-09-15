// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_ext_state.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_badge.dart';
import '../../../components/mt_card.dart';
import '../../../components/mt_progress.dart';
import '../../../components/text_widgets.dart';
import '../../../presenters/task_overview_presenter.dart';
import 'task_state_indicator.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({required this.task, this.onTap, this.expanded = false});

  final Task task;
  final VoidCallback? onTap;
  final bool expanded;

  bool get isClosed => task.closed;

  Widget title(BuildContext context) => H4(
        task.title,
        maxLines: 1,
        decoration: isClosed ? TextDecoration.lineThrough : null,
      );

  Widget header(BuildContext context) => Row(children: [
        Expanded(child: title(context)),
        if (task.openedLeafTasksCount > 0) MTBadge('${task.openedLeafTasksCount}'),
        SizedBox(width: onePadding / 4),
        chevronIcon(context),
      ]);

  @override
  Widget build(BuildContext context) => MTCard(
        onTap: onTap,
        body: MTProgress(
          ratio: task.doneRatio,
          color: task.stateColor,
          height: onePadding * 0.75,
          body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            header(context),
            SizedBox(height: onePadding / 2),
            Row(children: [
              task.showState ? Expanded(child: TaskStateIndicator(task, placement: IndicatorPlacement.card)) : const Spacer(),
              if (task.hasLink) linkIcon(context),
              SizedBox(width: onePadding / 4),
            ]),
          ]),
        ),
      );
}
