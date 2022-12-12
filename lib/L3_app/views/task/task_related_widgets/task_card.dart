// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/usecases/task_ext_actions.dart';
import '../../../../../L1_domain/usecases/task_ext_level.dart';
import '../../../../../L1_domain/usecases/task_ext_state.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_card.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/state_presenter.dart';
import 'state_title.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(this.task, {this.margin});

  @protected
  final Task task;
  final EdgeInsets? margin;

  bool get _hasStatus => task.status != null;
  bool get _hasAssignee => task.assignee != null;

  Widget get title => H4(
        task.title,
        maxLines: 2,
        decoration: task.closed ? TextDecoration.lineThrough : null,
      );

  Widget get header => Row(children: [
        Expanded(child: title),
        // if (task.openedLeafTasksCount > 0) MTBadge('${task.openedLeafTasksCount}'),
        // const SizedBox(width: P / 4),
        const ChevronIcon(),
      ]);

  bool get _showLink => task.hasLink && task.isProject;

  Widget get _estimate => SmallText('${task.estimate} ${loc.task_estimate_unit}', color: darkGreyColor);
  // List<Widget> get _dueDate => [
  //       const SizedBox(height: P_3),
  //       Row(
  //         children: [
  //           const CalendarIcon(size: P * 1.5, color: lightGreyColor),
  //           SmallText('${task.dueDate?.strMedium}', color: darkGreyColor, padding: const EdgeInsets.only(left: P_3)),
  //         ],
  //       ),
  //     ];

  @override
  Widget build(BuildContext context) => MTCardButton(
        onTap: () => mainController.showTask(context, task.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            header,
            // if (task.hasDueDate) ..._dueDate,
            if (task.showState || _showLink) ...[
              const SizedBox(height: P_3),
              Row(children: [
                if (task.showState) Expanded(child: TaskStateTitle(task)),
                if (_showLink) const LinkIcon(),
              ]),
            ],
            Row(
              children: [
                if (!task.closed && _hasStatus) SmallText(task.status!.title, color: darkGreyColor),
                if (_hasAssignee) SmallText(' @ ${task.assignee}', color: darkGreyColor),
                if (task.hasEstimate && !task.showState) ...[
                  const Spacer(),
                  _estimate,
                ]
              ],
            ),
          ],
        ),
      );
}
