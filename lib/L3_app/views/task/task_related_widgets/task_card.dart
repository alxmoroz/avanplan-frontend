// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/usecases/task_ext_actions.dart';
import '../../../../../L1_domain/usecases/task_ext_state.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_badge.dart';
import '../../../components/mt_card.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/state_presenter.dart';
import 'state_title.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(this.task, {this.expanded = false});

  final Task task;
  final bool expanded;

  Widget get title => H4(
        task.title,
        maxLines: 1,
        decoration: task.closed ? TextDecoration.lineThrough : null,
      );

  Widget get header => Row(children: [
        Expanded(child: title),
        if (task.openedLeafTasksCount > 0) MTBadge('${task.openedLeafTasksCount}'),
        SizedBox(width: onePadding / 4),
        const ChevronIcon(),
      ]);

  @override
  Widget build(BuildContext context) => MTCard(
        onTap: () => mainController.showTask(context, task.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            header,
            if (task.showState || task.hasLink) ...[
              SizedBox(height: onePadding / 3),
              Row(children: [
                if (task.showState) Expanded(child: TaskStateTitle(task)) else const Spacer(),
                if (task.hasLink) const LinkIcon(),
              ]),
            ],
          ],
        ),
      );
}
