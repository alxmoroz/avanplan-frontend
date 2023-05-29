// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../L1_domain/entities_extensions/task_level.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_card.dart';
import '../../../components/mt_list_tile.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/person_presenter.dart';
import '../../../presenters/task_level_presenter.dart';
import '../../../presenters/task_state_presenter.dart';
import '../../../usecases/task_ext_refs.dart';
import 'state_title.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(this.task, {this.margin, this.board = false, this.showBreadcrumbs = false});

  @protected
  final Task task;
  final EdgeInsets? margin;
  final bool board;
  final bool showBreadcrumbs;

  bool get _showStatus => !board && task.status != null;
  bool get _hasAssignee => task.assignee != null;

  Widget get _title => H4(
        task.title,
        maxLines: 2,
        decoration: task.closed && !board ? TextDecoration.lineThrough : null,
      );

  Widget get _header => Row(
        children: [
          if (!board && task.wsCode.isNotEmpty) SmallText(task.wsCode, color: lightGreyColor),
          Expanded(child: _title),
          if (!board) const ChevronIcon(),
        ],
      );

  bool get _showLink => task.hasLink && task.isProject;

  Widget get _estimate => SmallText('${task.estimate} ${loc.task_estimate_unit}', color: greyColor);

  Widget get _taskContent => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showBreadcrumbs && task.parent != null) SmallText(task.parent!.parentsTitles.sublist(1).join(' > '), color: lightGreyColor),
          _header,
          if (task.canShowState || _showLink) ...[
            const SizedBox(height: P_3),
            Row(children: [
              if (task.canShowState) Expanded(child: TaskStateTitle(task)),
              if (_showLink) const LinkIcon(),
            ]),
          ],
          const SizedBox(height: P_6),
          Row(
            children: [
              if (!task.closed && _showStatus) SmallText(task.status!.code, color: greyColor),
              if (task.hasEstimate && !task.canShowState) ...[
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
      );

  Future _tap() async => await mainController.showTask(task.wsId, task.id);

  @override
  Widget build(BuildContext context) => board
      ? MTCardButton(
          color: backgroundColor,
          elevation: cardElevation,
          child: _taskContent,
          onTap: _tap,
        )
      : MTListTile(
          middle: _taskContent,
          onTap: _tap,
        );
}
