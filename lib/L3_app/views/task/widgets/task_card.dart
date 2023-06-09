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
  const TaskCard(
    this.task, {
    this.showStateMark = false,
    this.board = false,
    this.showBreadcrumbs = false,
    this.bottomBorder = false,
    this.dragging = false,
  });

  final Task task;
  final bool board;
  final bool showBreadcrumbs;
  final bool bottomBorder;
  final bool showStateMark;
  final bool dragging;

  Widget get _title => NormalText(task.title, maxLines: 2, color: task.closed ? lightGreyColor : null);

  Widget get _header => Row(
        children: [
          if (!board && task.wsCode.isNotEmpty) SmallText(task.wsCode, color: lightGreyColor),
          Expanded(child: _title),
          if (!board) const ChevronIcon(),
        ],
      );

  bool get _showLink => task.hasLink && task.isProject;
  Widget get _estimate => SmallText('${task.estimate} ${loc.task_estimate_unit}', color: task.closed ? lightGreyColor : greyColor);
  Widget get _assignee => task.assignee!.iconName(card: true, color: task.closed ? lightGreyColor : null);

  Widget get _taskContent => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showBreadcrumbs && task.parent != null) SmallText(task.parent!.title, color: lightGreyColor),
          _header,
          if (task.canShowState || _showLink) ...[
            const SizedBox(height: P_3),
            Row(children: [
              if (task.canShowState) Expanded(child: TaskStateTitle(task)),
              if (_showLink) const LinkIcon(),
            ]),
          ] else if (!task.canShowState) ...[
            if (!board) ...[
              if (task.hasStatus) ...[
                const SizedBox(height: P_6),
                Row(
                  children: [
                    SmallText('${task.status}', color: task.closed ? lightGreyColor : greyColor),
                    if (task.hasEstimate) ...[const Spacer(), _estimate],
                  ],
                ),
              ],
            ],
            if (task.hasAssignee || task.hasEstimate) ...[
              const SizedBox(height: P_6),
              Row(
                children: [
                  if (task.hasAssignee) _assignee,
                  if (board && task.hasEstimate) ...[const Spacer(), _estimate],
                ],
              ),
            ],
          ],
        ],
      );

  Future _tap() async => await mainController.showTask(task.wsId, task.id);

  @override
  Widget build(BuildContext context) => board
      ? MTCardButton(
          elevation: dragging ? 3 : cardElevation,
          margin: const EdgeInsets.symmetric(horizontal: P, vertical: P_2),
          padding: const EdgeInsets.symmetric(horizontal: P, vertical: P_2),
          child: _taskContent,
          onTap: _tap,
        )
      : Stack(
          children: [
            MTListTile(
              leading: showStateMark ? const SizedBox(width: P_2) : null,
              middle: _taskContent,
              bottomBorder: bottomBorder,
              onTap: _tap,
            ),
            if (showStateMark)
              Positioned(
                left: P + P_2,
                top: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: stateGradient(task.overallState),
                  ),
                  width: P_2,
                ),
              ),
          ],
        );
}
