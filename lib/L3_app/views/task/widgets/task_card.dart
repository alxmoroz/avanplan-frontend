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
import '../../../components/button.dart';
import '../../../components/circle.dart';
import '../../../components/colors_base.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/list_tile.dart';
import '../../../components/loader.dart';
import '../../../components/text.dart';
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
    this.bottomDivider = false,
    this.dragging = false,
    this.isMine = false,
  });

  final Task task;
  final bool board;
  final bool showParent;
  final bool bottomDivider;
  final bool showStateMark;
  final bool dragging;
  final bool isMine;

  Color? get _textColor => task.closed ? f2Color : null;

  Widget get _parentTitle => SmallText(
        '${task.project?.wsCode}${task.parent!.title}',
        height: 1,
        maxLines: 1,
      );

  Widget get _title => Row(
        children: [
          if (task.wsCode.isNotEmpty) BaseText.f2(task.wsCode),
          Expanded(child: BaseText(task.title, maxLines: 2, color: _textColor)),
          if (!board) const ChevronIcon(),
        ],
      );

  Widget get _error => Row(children: [
        const ErrorIcon(),
        const SizedBox(width: P_2),
        SmallText(task.error!.title, color: _textColor, height: 1, maxLines: 1),
      ]);

  bool get _showDate => task.hasDueDate && !task.closed && task.isTask;
  Color get _dateColor => task.dueDate!.isBefore(tomorrow) ? stateColor(task.leafState) : _textColor ?? f2Color;
  Widget get _date => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CalendarIcon(color: _dateColor, size: P3),
          const SizedBox(width: P_2),
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
          SmallText('${task.notes.length} ', color: f2Color, height: 1),
          NoteMarkIcon(
            mine: task.notes.any((n) => n.isMine(task)),
            theirs: task.notes.any((n) => !n.isMine(task)),
          ),
        ],
      );

  bool get _showEstimate => task.hasEstimate && !task.closed;
  Widget get _estimate => SmallText('${(task.openedVolume ?? task.estimate)?.round()} ${task.ws.estimateUnitCode}', color: _textColor, height: 1);

  Widget get _divider => const Padding(
        padding: EdgeInsets.symmetric(horizontal: P),
        child: MTCircle(size: 4, color: f2Color),
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
            const SizedBox(height: P_2),
            Row(children: [
              Expanded(child: TaskStateTitle(task, place: StateTitlePlace.card)),
              if (_showNotesMark) ...[_notesMark],
              if (task.isLinkedProject) ...[if (_showNotesMark) _divider, const LinkIcon(color: f2Color)]
            ]),
            // листья - срок, метка комментов, оценка, статус, назначено
          ] else ...[
            if (_showDate || _showNotesMark || _showStatus || _showAssignee || task.hasEstimate) ...[
              const SizedBox(height: P_2),
              Row(
                children: [
                  if (_showDate) _date,
                  const Spacer(),
                  if (_showNotesMark) ...[_notesMark],
                  if (_showEstimate) ...[if (_showNotesMark) _divider, _estimate],
                  if (_showStatus) ...[if (_showNotesMark || _showEstimate) _divider, _status],
                  if (_showAssignee) ...[const SizedBox(width: P), _assignee],
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
          margin: const EdgeInsets.symmetric(horizontal: P2, vertical: P),
          padding: const EdgeInsets.symmetric(horizontal: P2, vertical: P),
          loading: task.loading,
          child: _taskContent,
          onTap: _tap,
        )
      : Stack(
          children: [
            MTListTile(
              leading: showStateMark ? const SizedBox(width: P) : null,
              middle: _taskContent,
              dividerLeftIndent: showStateMark ? P6 : 0,
              bottomDivider: bottomDivider,
              onTap: _tap,
            ),
            if (task.loading == true) const MTLoader(),
            if (showStateMark)
              Positioned(
                left: P3,
                top: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(gradient: stateGradient(context, task.overallState)),
                  width: P,
                ),
              ),
          ],
        );
}
