// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_level.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_card.dart';
import '../../../components/mt_circle.dart';
import '../../../components/mt_list_tile.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/date_presenter.dart';
import '../../../presenters/person_presenter.dart';
import '../../../presenters/task_level_presenter.dart';
import '../../../presenters/task_state_presenter.dart';
import '../../../usecases/task_ext_actions.dart';
import '../../../usecases/task_ext_refs.dart';
import '../task_view_controller.dart';
import 'state_title.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(
    this.task, {
    this.showStateMark = false,
    this.board = false,
    this.showParent = false,
    this.bottomBorder = false,
    this.dragging = false,
    this.filters,
  });

  final Task task;
  final bool board;
  final bool showParent;
  final bool bottomBorder;
  final bool showStateMark;
  final bool dragging;
  final Set<TasksFilter>? filters;

  Color? get _textColor => task.closed ? lightGreyColor : null;

  Widget get _parentTitle => LightText(
        '${task.project?.wsCode}${task.parent!.title}',
        color: _textColor,
        sizeScale: 0.85,
      );

  Widget get _title => Row(
        children: [
          if (task.wsCode.isNotEmpty) LightText(task.wsCode, color: lightGreyColor),
          Expanded(child: NormalText(task.title, maxLines: 2, color: _textColor)),
          if (!board) const ChevronIcon(),
        ],
      );

  bool get _showDate => task.hasDueDate && task.isLeaf;
  Widget get _date => Row(children: [
        CalendarIcon(color: stateColor(task.state)),
        const SizedBox(width: P_3),
        SmallText(task.dueDate!.strMedium, color: _textColor ?? stateColor(task.state)),
      ]);

  bool get _showStatus => task.hasStatus && !board;
  Widget get _status => SmallText('${task.status}', color: _textColor);

  bool get _showAssignee => task.hasAssignee && filters?.contains(TasksFilter.my) != true;
  Widget get _assignee => task.assignee!.icon(P * (board ? 1 : 1.3));

  bool get _showEstimate => task.hasEstimate;
  Widget get _estimate => SmallText('${task.sumEstimate} ${loc.task_estimate_unit}', color: _textColor);

  Widget get _divider => const Padding(
        padding: EdgeInsets.symmetric(horizontal: P),
        child: MTCircle(size: P_3, color: lightGreyColor),
      );

  Widget get _taskContent => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showParent && task.parent != null) _parentTitle,
          _title,
          // проекты, цели или группы задач
          if (task.canShowState || task.isLinkedProject) ...[
            const SizedBox(height: P_6),
            Row(children: [
              if (task.canShowState) Expanded(child: TaskStateTitle(task)),
              if (task.isLinkedProject) const LinkIcon(),
            ]),
            // не проекты, не цели и не группы задач
          ] else if (!task.canShowState) ...[
            if (_showDate || _showStatus || _showAssignee || task.hasEstimate) ...[
              const SizedBox(height: P_6),
              Row(
                children: [
                  if (_showDate) _date,
                  const Spacer(),
                  if (_showEstimate) ...[_estimate],
                  if (_showStatus) ...[if (_showEstimate) _divider, _status],
                  if (_showAssignee) ...[const SizedBox(width: P), _assignee],
                ],
              ),
            ],
          ],
        ],
      );

  Future _tap() async => await mainController.showTask(TaskParams(task.wsId, taskId: task.id));

  @override
  Widget build(BuildContext context) => board
      ? MTCardButton(
          elevation: dragging ? 3 : null,
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
              bottomDivider: bottomBorder,
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
