// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../L1_domain/entities/task.dart';
import '../../../../../../L1_domain/entities_extensions/task_dates.dart';
import '../../../../../../L1_domain/entities_extensions/task_params.dart';
import '../../../../../../L1_domain/entities_extensions/task_state.dart';
import '../../../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../../L1_domain/utils/dates.dart';
import '../../../../components/button.dart';
import '../../../../components/circle.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../navigation/router.dart';
import '../../../../presenters/date.dart';
import '../../../../presenters/note.dart';
import '../../../../presenters/project_module.dart';
import '../../../../presenters/task_actions.dart';
import '../../../../presenters/task_estimate.dart';
import '../../../../presenters/task_state.dart';
import '../../../../presenters/task_tree.dart';
import '../../../../presenters/task_type.dart';
import '../../../../presenters/task_view.dart';
import '../../../../presenters/ws_member.dart';
import '../../../../usecases/task_status.dart';
import '../analytics/state_title.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(
    this.task, {
    super.key,
    this.showStateMark = false,
    this.board = false,
    this.showParent = false,
    this.bottomDivider = false,
    this.dragging = false,
    this.showAssignee = true,
    this.onTap,
  });

  final Task task;
  final bool board;
  final bool showParent;
  final bool bottomDivider;
  final bool showStateMark;
  final bool dragging;
  final bool showAssignee;
  final Function(Task)? onTap;

  void _tap(Task task) => onTap != null ? onTap!(task) : router.goTaskView(task);

  Color? get _textColor => task.closed || task.isImportingProject ? f2Color : null;

  Widget get _parentTitle => SmallText(task.parent!.title, maxLines: 1);

  Widget get _title => Row(
        children: [
          Expanded(child: BaseText(task.title, maxLines: 2, color: _textColor)),
          if (!board && !task.isImportingProject) const ChevronIcon(),
        ],
      );

  Widget _error(String errText) => Row(children: [
        const ErrorIcon(),
        const SizedBox(width: P_2),
        SmallText(errText, color: _textColor, maxLines: 1),
      ]);
  bool get _showRepeat => task.hasRepeat;
  bool get _showDate => task.hasDueDate && !task.closed && task.isTask && (task.leafState != TaskState.TODAY || board);
  Color get _dateColor => task.dueDate!.isBefore(tomorrow) ? stateColor(task.leafState) : _textColor ?? f2Color;

  Widget get _date => Row(
        children: [
          CalendarIcon(color: _dateColor, size: P3, endMark: true),
          const SizedBox(width: P_2),
          SmallText(task.dueDate!.strMedium, color: _dateColor, maxLines: 1),
        ],
      );
  bool get _showStatus => task.canShowStatus && !board && !task.closed;

  Widget get _status => SmallText('${task.status}', color: _textColor, maxLines: 1);
  bool get _showAssignee => task.hmTeam && task.hasAssignee && showAssignee;

  Widget get _assignee => task.assignee!.icon(P2 + P_2);
  bool get _showChecklistMark => !task.closed && task.isCheckList;

  Widget get _checklistMark => Row(
        children: [
          SmallText('${task.closedSubtasksCount}/${task.subtasksCount} ', color: f2Color, maxLines: 1),
          const CheckboxIcon(true, size: P3, color: f2Color),
        ],
      );
  bool get _showAttachmentsMark => !task.closed && task.attachmentsCount > 0;

  Widget get _attachmentsMark => Row(
        children: [
          SmallText('${task.attachmentsCount} ', color: f2Color, maxLines: 1),
          const AttachmentIcon(size: P3, color: f2Color),
        ],
      );
  bool get _showNotesMark => !task.closed && task.notesCount > 0;

  Widget get _notesMark => Row(
        children: [
          SmallText('${task.notesCount} ', color: f2Color, maxLines: 1),
          NoteMarkIcon(
            mine: task.notes.any((n) => n.isMine(task)),
            theirs: task.notes.any((n) => !n.isMine(task)),
          ),
        ],
      );
  bool get _showEstimate => task.hmAnalytics && task.hasEstimate;

  Widget get _estimate => SmallText(task.estimateStr, color: _textColor, maxLines: 1);

  Widget get _divider => const Padding(
        padding: EdgeInsets.symmetric(horizontal: P),
        child: MTCircle(size: 4, color: f2Color),
      );

  Widget _taskContent(bool withDetails) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showParent && task.parent != null) ...[
            _parentTitle,
            const SizedBox(height: P_2),
          ],
          _title,
          // ошибки
          if (task.error != null)
            _error(task.error!.message)
          // проекты, цели или группы задач: интегральная оценка, метка связанного проекта, вложений и комментариев
          else if (task.isGroup &&
              (task.hasAnalytics || _showAttachmentsMark || _showNotesMark || task.isLinkedProject || task.wsCode.isNotEmpty)) ...[
            const SizedBox(height: P_2),
            Row(
              children: [
                if (task.hasAnalytics) TaskStateTitle(task, place: StateTitlePlace.card),
                const Spacer(),
                if (_showAttachmentsMark) ...[_attachmentsMark],
                if (_showNotesMark) ...[if (_showAttachmentsMark) _divider, _notesMark],
                if (task.isLinkedProject) ...[if (_showAttachmentsMark || _showNotesMark) _divider, const LinkIcon(color: f2Color)],
                if (task.wsCode.isNotEmpty) SmallText(task.wsCode, color: f3Color, maxLines: 1),
              ],
            ),
            // задачи: срок, метка чек-листа, вложений, комментов, оценка, статус, назначено
          ] else if (_showRepeat ||
              _showDate ||
              _showChecklistMark ||
              _showAttachmentsMark ||
              _showNotesMark ||
              _showStatus ||
              _showAssignee ||
              _showEstimate) ...[
            SizedBox(height: board ? P_2 : P),
            Row(
              children: [
                if (_showDate) _date,
                if (_showRepeat) ...[if (_showDate) const SizedBox(width: P), const RepeatIcon(size: P2 + P_2, color: f2Color)],
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(width: P2),
                      if (withDetails) ...[
                        if (_showChecklistMark) ...[_checklistMark],
                        if (_showAttachmentsMark) ...[if (_showChecklistMark) _divider, _attachmentsMark],
                        if (_showNotesMark) ...[if (_showChecklistMark || _showAttachmentsMark) _divider, _notesMark],
                      ],
                      if (_showEstimate) ...[
                        if (withDetails && (_showChecklistMark || _showAttachmentsMark || _showNotesMark)) _divider,
                        _estimate,
                      ],
                      if (_showStatus) ...[
                        if (withDetails && (_showChecklistMark || _showAttachmentsMark || _showNotesMark) || _showEstimate) _divider,
                        Flexible(child: _status),
                      ],
                      if (_showAssignee) ...[const SizedBox(width: P), _assignee],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      );

  @override
  Widget build(BuildContext context) => board
      ? MTCardButton(
          elevation: dragging ? 3 : null,
          margin: const EdgeInsets.symmetric(horizontal: P2, vertical: P),
          padding: const EdgeInsets.symmetric(horizontal: P2, vertical: P),
          loading: task.loading,
          onTap: dragging ? null : () => _tap(task),
          child: _taskContent(false),
        )
      : Stack(
          children: [
            MTListTile(
              leading: showStateMark ? const SizedBox(width: P) : null,
              middle: LayoutBuilder(builder: (_, size) => _taskContent(size.maxWidth > SCR_S_WIDTH)),
              bottomDivider: bottomDivider,
              dividerIndent: showStateMark ? P6 : 0,
              loading: task.loading,
              onTap: task.isImportingProject || dragging ? null : () => _tap(task),
            ),
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
