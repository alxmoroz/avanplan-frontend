// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/task_ext_state.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_badge.dart';
import '../../../components/mt_card.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_state_presenter.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(this.task, {this.expanded = false});

  final Task task;
  final bool expanded;

  Widget title(BuildContext context) => H4(
        task.title,
        maxLines: 1,
        decoration: task.closed ? TextDecoration.lineThrough : null,
      );

  Widget header(BuildContext context) => Row(children: [
        Expanded(child: title(context)),
        if (task.openedLeafTasksCount > 0) MTBadge('${task.openedLeafTasksCount}'),
        SizedBox(width: onePadding / 4),
        chevronIcon(context),
      ]);

  @override
  Widget build(BuildContext context) => MTCard(
        onTap: () => mainController.showTask(context, task.id),
        padding: EdgeInsets.all(onePadding),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          header(context),
          SizedBox(height: onePadding / 3),
          Row(children: [
            if (task.showState) ...[
              task.stateIcon(context, size: onePadding * 1.3, color: task.stateColor),
              SizedBox(width: onePadding / 4),
              Expanded(child: SmallText(task.stateTitle, color: task.stateColor)),
            ] else
              const Spacer(),
            if (task.hasLink) linkIcon(context),
          ]),
        ]),
      );
}
