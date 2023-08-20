// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_state.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../../L1_domain/entities_extensions/task_status.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../L1_domain/utils/dates.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_button.dart';
import '../../../components/mt_circle.dart';
import '../../../components/mt_list_tile.dart';
import '../../../components/mt_loader.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/date.dart';
import '../../../presenters/note.dart';
import '../../../presenters/person.dart';
import '../../../presenters/task_state.dart';
import '../../../presenters/task_tree.dart';
import '../../../presenters/task_type.dart';
import '../../../presenters/workspace.dart';
import '../../../usecases/task_available_actions.dart';
import 'state_title.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(
    this.task, {
    this.showStateMark = false,
    this.board = false,
    this.showParent = false,
    this.bottomBorder = false,
    this.dragging = false,
    this.isMine = false,
  });

  final Task task;
  final bool board;
  final bool showParent;
  final bool bottomBorder;
  final bool showStateMark;
  final bool dragging;
  final bool isMine;

  Color? get _textColor => task.closed ? lightGreyColor : null;

  Widget get _parentTitle => LightText(
        '${task.project?.wsCode}${task.parent!.title}',
        color: _textColor,
        sizeScale: 0.85,
        height: 1,
        maxLines: 1,
      );

  Widget get _title => Row(
        children: [
          if (task.wsCode.isNotEmpty) LightText(task.wsCode, color: lightGreyColor),
          Expanded(child: NormalText(task.title, maxLines: 2, color: _textColor)),
          if (!board) const ChevronIcon(),
        ],
      );

  Widget get _error => Row(children: [
        const ErrorIcon(),
        const SizedBox(width: P_3),
        SmallText(task.error!.title, color: _textColor, height: 1, maxLines: 1),
      ]);

  bool get _showDate => task.hasDueDate && !task.closed && task.isTask;
  Color get _dateColor => task.dueDate!.isBefore(tomorrow) ? stateColor(task.leafState) : _textColor ?? greyColor;
  Widget get _date => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CalendarIcon(color: _dateColor, size: P * 1.6),
          const SizedBox(width: P_3),
          SmallText(task.dueDate!.strMedium, color: _dateColor, height: 1),
        ],
      );

  bool get _showStatus => task.hasStatus && !board && !task.closed;
  Widget get _status => SmallText('${task.status}', color: _textColor, height: 1);

  bool get _showAssignee => task.hasAssignee && !isMine;
  Widget get _assignee => task.assignee!.icon(P * (board ? 1 : 1.35));

  bool get _showNotesMark => !task.closed && task.notes.isNotEmpty;
  Widget get _notesMark => Row(
        children: [
          SmallText('${task.notes.length} ', color: greyColor, height: 1),
          NoteMarkIcon(
            mine: task.notes.any((n) => n.isMine(task)),
            theirs: task.notes.any((n) => !n.isMine(task)),
          ),
        ],
      );

  bool get _showEstimate => task.hasEstimate && !task.closed;
  Widget get _estimate => SmallText('${(task.openedVolume ?? task.estimate)?.round()} ${task.ws.estimateUnitCode}', color: _textColor, height: 1);

  Widget get _divider => const Padding(
        padding: EdgeInsets.symmetric(horizontal: P_2),
        child: MTCircle(size: P_3, color: lightGreyColor),
      );

  Widget get _taskContent => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showParent && task.parent != null) _parentTitle,
          _title,
          // ошибка
          if (task.error != null)
            _error
          // проекты, цели или группы задач - интегральная оценка, метка связанного проекта и комментариев
          else if (task.isOpenedGroup) ...[
            const SizedBox(height: P_6),
            Row(children: [
              Expanded(child: TaskStateTitle(task)),
              if (_showNotesMark) ...[_notesMark],
              if (task.isLinkedProject) ...[if (_showNotesMark) _divider, const LinkIcon(color: lightGreyColor)]
            ]),
            // листья - срок, метка комментов, оценка, статус, назначено
          ] else ...[
            if (_showDate || _showNotesMark || _showStatus || _showAssignee || task.hasEstimate) ...[
              const SizedBox(height: P_6),
              Row(
                children: [
                  if (_showDate) _date,
                  const Spacer(),
                  if (_showNotesMark) ...[_notesMark],
                  if (_showEstimate) ...[if (_showNotesMark) _divider, _estimate],
                  if (_showStatus) ...[if (_showNotesMark || _showEstimate) _divider, _status],
                  if (_showAssignee) ...[const SizedBox(width: P_2), _assignee],
                ],
              ),
            ],
          ],
        ],
      );

  Future _tap() async => await mainController.showTask(task);

  @override
  Widget build(BuildContext context) => board
      ? MTCardButton(
          elevation: dragging ? 3 : null,
          margin: const EdgeInsets.symmetric(horizontal: P, vertical: P_2),
          padding: const EdgeInsets.symmetric(horizontal: P, vertical: P_2),
          loading: task.loading,
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
            if (task.loading == true) const MTLoader(),
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
