// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../L1_domain/entities_extensions/task_level.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../L2_data/services/platform.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_card.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/person_presenter.dart';
import '../../../presenters/state_presenter.dart';
import 'state_title.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(this.task, {this.margin});

  @protected
  final Task task;
  final EdgeInsets? margin;

  bool get _hasStatus => task.status != null;
  bool get _hasAssignee => task.assignee != null;

  Widget get _title => H4(
        task.title,
        maxLines: 2,
        decoration: task.closed ? TextDecoration.lineThrough : null,
      );

  Widget get _header => Row(children: [
        Expanded(child: _title),
        // if (task.openedLeafTasksCount > 0) MTBadge('${task.openedLeafTasksCount}'),
        // const SizedBox(width: P / 4),
        const ChevronIcon(),
      ]);

  bool get _showLink => task.hasLink && task.isProject;

  Widget get _estimate => SmallText('${task.estimate} ${loc.task_estimate_unit}', color: greyColor);

  @override
  Widget build(BuildContext context) => MTCardButton(
        elevation: isWeb ? 3 : null,
        onTap: () => mainController.showTask(task.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            _header,
            if (task.showState || _showLink) ...[
              const SizedBox(height: P_3),
              Row(children: [
                if (task.showState) Expanded(child: TaskStateTitle(task)),
                if (_showLink) const LinkIcon(),
              ]),
            ],
            const SizedBox(height: P_6),
            Row(
              children: [
                if (!task.closed && _hasStatus) SmallText(task.status!.code, color: greyColor),
                if (task.hasEstimate && !task.showState) ...[
                  const Spacer(),
                  _estimate,
                ]
              ],
            ),
            if (_hasAssignee) ...[
              const SizedBox(height: P_6),
              task.assignee!.iconName(),
            ]
          ],
        ),
      );
}
