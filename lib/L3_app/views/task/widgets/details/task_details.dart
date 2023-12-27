// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/feature_set.dart';
import '../../../../presenters/source.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_source.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../attachments/attachments.dart';
import '../feature_sets/feature_sets.dart';
import '../notes/notes.dart';
import '../project_statuses/project_statuses.dart';
import '../tasks/task_checklist.dart';
import 'assignee_field.dart';
import 'checklist_add_field.dart';
import 'description_field.dart';
import 'due_date_field.dart';
import 'estimate_field.dart';
import 'start_date_field.dart';
import 'task_status_field.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails(this._controller, {this.standalone = false, this.compact = false});
  final TaskController _controller;
  final bool standalone;
  final bool compact;

  Task get _task => _controller.task!;

  bool get _isTaskDialog => isBigScreen && _task.isTask;
  bool get _isTaskView => !isBigScreen && _task.isTask;
  bool get _showStatusRow => _isTaskView && (_task.canShowStatus || _task.canClose || _task.closed);
  bool get _showDescription => !_isTaskDialog && (_task.hasDescription || _task.canEdit);

  bool get _hasMargins => standalone || _isTaskView;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView(
        shrinkWrap: true,
        // physics: standalone ? null : const NeverScrollableScrollPhysics(),
        children: [
          /// Статус
          if (_showStatusRow) TaskStatusField(_controller),

          /// Описание
          if (_showDescription) TaskDescriptionField(_controller, compact: compact, hasMargin: _hasMargins && !_showStatusRow),

          /// Назначенный
          if (_task.canShowAssignee) TaskAssigneeField(_controller, compact: compact, hasMargin: _hasMargins),

          /// Кнопка для добавления чек-листа
          if (!_isTaskDialog && _task.canAddChecklist) TaskChecklistAddField(_controller),

          /// Чек-лист
          if (!_isTaskDialog && _task.isCheckList) ...[
            const SizedBox(height: P3),
            TaskChecklist(_controller),
          ],

          /// Даты
          TaskStartDateField(_controller, compact: compact, hasMargin: _hasMargins),
          if (_task.hasDueDate || _task.canEdit) TaskDueDateField(_controller, compact: compact, hasMargin: _hasMargins),

          /// Оценки
          if (_task.canEstimate) TaskEstimateField(_controller, compact: compact, hasMargin: _hasMargins),

          /// Вложения
          if (!_isTaskDialog && _task.attachments.isNotEmpty)
            MTField(
              _controller.fData(TaskFCode.attachment.index),
              margin: EdgeInsets.only(top: _hasMargins ? P3 : 0),
              leading: const AttachmentIcon(),
              value: Row(children: [
                Flexible(child: BaseText(_controller.attachmentsController.attachmentsStr, maxLines: 1)),
                if (_controller.attachmentsController.attachmentsCountMoreStr.isNotEmpty)
                  BaseText.f2(
                    _controller.attachmentsController.attachmentsCountMoreStr,
                    maxLines: 1,
                    padding: const EdgeInsets.only(left: P),
                  )
              ]),
              onTap: () => showAttachmentsDialog(_controller.attachmentsController),
            ),

          /// FeatureSets
          if (_task.canShowFeatureSets)
            MTField(
              _controller.fData(TaskFCode.features.index),
              margin: EdgeInsets.only(top: _hasMargins ? P3 : 0),
              leading: SettingsIcon(color: _task.canEditFeatureSets ? null : f3Color),
              value: BaseText(_task.localizedFeatureSets, maxLines: 1),
              compact: compact,
              onTap: _task.canEditFeatureSets ? () => showFeatureSetsDialog(_controller) : null,
            ),

          /// Набор статусов
          if (_task.canEditProjectStatuses)
            MTField(
              _controller.fData(TaskFCode.statuses.index),
              margin: EdgeInsets.only(top: _hasMargins ? P3 : 0),
              leading: const StatusIcon(),
              value: _task.projectStatuses.isNotEmpty ? BaseText(_controller.projectStatusesController.statusesStr, maxLines: 1) : null,
              compact: compact,
              onTap: () => showProjectStatusesDialog(_controller.projectStatusesController),
            ),

          /// Связь с источником импорта
          if (_task.didImported)
            MTListTile(
              margin: EdgeInsets.only(top: _hasMargins ? P3 : 0),
              leading: _task.source?.type.icon(size: P6),
              titleText: !compact ? loc.task_go2source_title : null,
              trailing: !compact ? const LinkOutIcon() : null,
              bottomDivider: false,
              onTap: () => launchUrlString(_task.taskSource!.urlString),
            ),

          if (!_isTaskDialog && _controller.notesController.sortedNotesDates.isNotEmpty) Notes(_controller.notesController),
        ],
      ),
    );
  }
}
