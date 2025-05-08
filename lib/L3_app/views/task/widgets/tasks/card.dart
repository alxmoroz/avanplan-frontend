// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../../L1_domain/entities/task.dart';
import '../../../../../../L1_domain/entities_extensions/task_dates.dart';
import '../../../../../../L1_domain/entities_extensions/task_state.dart';
import '../../../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../../L1_domain/utils/dates.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/button.dart';
import '../../../../components/circle.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../navigation/router.dart';
import '../../../../presenters/date.dart';
import '../../../../presenters/note.dart';
import '../../../../presenters/task_actions.dart';
import '../../../../presenters/task_estimate.dart';
import '../../../../presenters/task_state.dart';
import '../../../../presenters/task_tree.dart';
import '../../../../presenters/task_type.dart';
import '../../../../presenters/task_view.dart';
import '../../../../presenters/ws_member.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
import '../../../../usecases/task_status.dart';
import '../../../app/services.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/state.dart';
import '../analytics/state_title.dart';

class TaskCard extends StatefulWidget {
  const TaskCard(
    this.task, {
    super.key,
    this.showStateMark = false,
    this.board = false,
    this.showParent = false,
    this.bottomDivider = false,
    this.dragging = false,
    this.showAssignee = true,
    this.readOnly = false,
    this.trailing,
    this.deleteIconData,
    this.deleteActionLabel,
    this.onTap,
    this.onDelete,
  });

  final Task task;
  final bool board;
  final bool showParent;
  final bool bottomDivider;
  final bool showStateMark;
  final bool dragging;
  final bool showAssignee;
  final bool readOnly;
  final Widget? trailing;
  final IconData? deleteIconData;
  final String? deleteActionLabel;
  final Function(Task)? onTap;
  final Function(Task)? onDelete;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TaskCard> {
  bool _cardHover = false;
  bool _delBtnHover = false;
  bool _deleting = false;

  IconData? get _delIconData => widget.deleteIconData ?? const DeleteIcon().iconData;

  Task get _t => widget.task;
  bool get _ro => widget.readOnly || _t.isImportingProject;
  bool get _inactive => _ro || _t.closed;
  bool get _canDelete => widget.onDelete != null && _t.canDelete;

  late final TaskController _tc;

  @override
  void initState() {
    _tc = TaskController(taskIn: _t);
    super.initState();
  }

  TaskState get _overallState => _tc.overallState;

  void _tap(Task task) => widget.onTap != null ? widget.onTap!(task) : router.goTask(task);

  Future<bool> _delete() async {
    setState(() => _deleting = true);
    widget.onDelete!(_t);
    setState(() => _deleting = false);
    return false;
  }

  Color? get _titleColor => _inactive ? f2Color : null;
  Color get _subtitleColor => _inactive ? f3Color : f2Color;

  Widget get _parentTitle => SmallText(_t.parent!.title, maxLines: 1);

  Widget _error(String errText) => Row(children: [
        const ErrorIcon(),
        const SizedBox(width: P_2),
        SmallText(errText, color: _subtitleColor, maxLines: 1),
      ]);

  /// даты
  bool get _showRepeat => _t.hasRepeat;
  bool get _showDate => _t.hasDueDate && !_t.closed && _t.isTask && (_t.leafState != TaskState.TODAY || widget.board);
  Color get _dateColor => _t.dueDate!.isBefore(tomorrow) ? stateColor(_t.leafState) : _titleColor ?? _subtitleColor;
  Widget get _date => Row(
        children: [
          CalendarIcon(color: _dateColor, size: P3),
          const SizedBox(width: P_2),
          SmallText(_t.dueDate!.strMedium, color: _dateColor, maxLines: 1),
        ],
      );

  /// статус
  bool get _showStatus => _t.canShowStatus && !widget.board && !_t.closed;
  Widget get _status => SmallText('${_t.status}', color: _subtitleColor, maxLines: 1);

  /// назначенный
  bool get _showAssignee => _t.canShowAssignee && widget.showAssignee;
  Widget get _assignee => _t.assignee!.icon(P2 + P_2);

  /// чеклист
  bool get _showChecklistMark => !_t.closed && _t.isCheckList;
  Widget get _checklistMark => Row(
        children: [
          SmallText('${_t.closedSubtasksCount}/${_t.subtasksCount} ', color: _subtitleColor, maxLines: 1),
          CheckboxIcon(true, size: P3, color: _subtitleColor),
        ],
      );

  /// вложения
  bool get _showAttachmentsMark => !_t.closed && _t.attachmentsCount > 0;
  Widget get _attachmentsMark => Row(
        children: [
          SmallText('${_t.attachmentsCount} ', color: _subtitleColor, maxLines: 1),
          AttachmentIcon(size: P3, color: _subtitleColor),
        ],
      );

  /// комментарии
  bool get _showNotesMark => !_t.closed && _t.notesCount > 0;
  Widget get _notesMark => Row(
        children: [
          SmallText('${_t.notesCount} ', color: _subtitleColor, maxLines: 1),
          NoteMarkIcon(
            mine: _t.notes.any((n) => n.isMine(_t)),
            theirs: _t.notes.any((n) => !n.isMine(_t)),
            color: _subtitleColor,
          ),
        ],
      );

  /// оценка
  bool get _showEstimate => _t.canShowEstimate;
  Widget get _estimate => SmallText(_t.estimateStr, color: _subtitleColor, maxLines: 1);

  Widget get _divider => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: MTCircle(size: 4, color: f3Color),
      );

  Widget get _deleteButton => Opacity(
        opacity: _cardHover ? 1 : 0,
        child: MTButton.icon(
          MTIcon(_delIconData, color: _delBtnHover ? dangerColor : f2Color, size: P4),
          padding: const EdgeInsets.only(left: P, right: P_2),
          onHover: (hover) => setState(() => _delBtnHover = hover),
          onTap: _delete,
        ),
      );

  Widget _taskContent(bool withDetails) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Хлебная крошка, название, шеврон / иконка удаления
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.showParent && _t.parent != null) ...[
                      _parentTitle,
                      const SizedBox(height: P_2),
                    ],
                    BaseText(_t.title, maxLines: 2, color: _titleColor),
                  ],
                ),
              ),
              if (widget.trailing != null)
                widget.trailing!
              else if (_canDelete && isWeb && _t.isTask)
                _deleteButton
              else if (!isWeb && !widget.board && !_ro)
                const ChevronIcon(),
            ],
          ),

          // ошибки
          if (_t.error != null)
            _error(_t.error!.message)
          // проекты, цели или группы задач: интегральная оценка, метка связанного проекта, вложений и комментариев
          else if (_t.isGroup && (_t.hasGroupAnalytics || _t.isLinkedProject || _t.wsCode.isNotEmpty)) ...[
            const SizedBox(height: P_2),
            Row(
              children: [
                if (_t.hasGroupAnalytics) StateTitle(_overallState, _tc.overallStateTitle, place: StateTitlePlace.card),
                const Spacer(),
                if (_t.isLinkedProject) LinkIcon(color: _subtitleColor),
                if (_t.wsCode.isNotEmpty) SmallText(_t.wsCode, color: f3Color, maxLines: 1),
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
            SizedBox(height: widget.board ? P_2 : P),
            Row(
              children: [
                if (_showDate) _date,
                if (_showRepeat) ...[if (_showDate) const SizedBox(width: P), RepeatIcon(size: P2 + P_2, color: _subtitleColor)],
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(width: P2),
                      if (_showChecklistMark) _checklistMark,
                      if (withDetails) ...[
                        if (_showAttachmentsMark) ...[if (_showChecklistMark) _divider, _attachmentsMark],
                        if (_showNotesMark) ...[if (_showChecklistMark || _showAttachmentsMark) _divider, _notesMark],
                      ],
                      if (_showEstimate) ...[
                        if (_showChecklistMark || (withDetails && (_showAttachmentsMark || _showNotesMark))) _divider,
                        _estimate,
                      ],
                      if (_showStatus) ...[
                        if (_showChecklistMark || (withDetails && (_showAttachmentsMark || _showNotesMark || _showEstimate))) _divider,
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

  Widget get _boardCard {
    return MTCardButton(
      elevation: widget.dragging ? 3 : null,
      margin: const EdgeInsets.symmetric(horizontal: P2, vertical: P),
      padding: const EdgeInsets.symmetric(horizontal: P2, vertical: P),
      loading: _t.loading,
      onTap: _ro || widget.dragging ? null : () => _tap(_t),
      child: _taskContent(false),
    );
  }

  Widget _listTile(BuildContext context) {
    final showStateMark = widget.showStateMark;
    final content = Stack(
      children: [
        MTListTile(
          leading: showStateMark ? const SizedBox(width: P) : null,
          middle: LayoutBuilder(builder: (_, size) => _taskContent(size.maxWidth > SCR_S_WIDTH)),
          bottomDivider: widget.bottomDivider,
          dividerIndent: showStateMark ? P6 : P3,
          loading: _deleting || _t.loading,
          onHover: !_ro && isWeb ? (hover) => setState(() => _cardHover = hover) : null,
          onTap: _ro || widget.dragging ? null : () => _tap(_t),
        ),
        if (showStateMark)
          Positioned(
            left: P3,
            top: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(gradient: stateGradient(context, _overallState)),
              width: P,
            ),
          ),
      ],
    );

    return _ro || isWeb || !_canDelete
        ? content
        : Slidable(
            key: ObjectKey(_t),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(
                onDismissed: () {},
                confirmDismiss: _delete,
              ),
              children: [
                SlidableAction(
                  onPressed: (_) async => await _delete(),
                  backgroundColor: dangerColor.resolve(context),
                  foregroundColor: b3Color.resolve(context),
                  icon: _delIconData,
                  label: widget.deleteActionLabel ?? loc.action_delete_title,
                ),
              ],
            ),
            child: content,
          );
  }

  @override
  Widget build(BuildContext context) => widget.board ? _boardCard : _listTile(context);
}
