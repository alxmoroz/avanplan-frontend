// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/field_data.dart';
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
import 'description_field.dart';
import 'due_date_field.dart';
import 'estimate_field.dart';
import 'start_date_field.dart';
import 'task_status_field.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails(this._controller, {this.standalone = false});
  final TaskController _controller;
  final bool standalone;

  bool get _isTaskDialog => isBigScreen && _task.isTask;

  Task get _task => _controller.task!;
  bool get _showStatusRow => !isBigScreen && _task.isTask && (_task.canShowStatus || _task.canClose || _task.closed);
  bool get _showAssignee => _task.canShowAssignee;
  bool get _showEstimate => _task.canShowEstimate;
  bool get _showDescription => !_isTaskDialog && (_task.hasDescription || _task.canEdit);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView(
        shrinkWrap: true,
        children: [
          /// Статус
          if (_showStatusRow) TaskStatusField(_controller),

          /// Описание
          if (_showDescription) TaskDescriptionField(_controller),

          /// Назначенный
          if (_showAssignee) TaskAssigneeField(_controller),

          /// Кнопка для добавления чек-листа
          if (!_isTaskDialog && _task.canAddChecklist)
            MTField(
              MTFieldData(-1, placeholder: '${loc.action_add_title} ${loc.checklist.toLowerCase()}'),
              margin: const EdgeInsets.only(top: P3),
              leading: const PlusCircleIcon(color: mainColor),
              crossAxisAlignment: CrossAxisAlignment.center,
              onTap: () async => await _controller.subtasksController.addTask(),
            ),

          /// Чек-лист
          if (!_isTaskDialog && _task.isCheckList) ...[
            const SizedBox(height: P3),
            TaskChecklist(_controller),
          ],

          /// Даты
          if (standalone) const SizedBox(height: P3),
          TaskStartDateField(_controller),
          if (_task.hasDueDate || _task.canEdit) TaskDueDateField(_controller),

          /// Оценки
          if (_showEstimate) ...[
            if (standalone) const SizedBox(height: P3),
            TaskEstimateField(_controller),
          ],

          /// Вложения
          if (!_isTaskDialog && _task.attachments.isNotEmpty)
            MTField(
              _controller.fData(TaskFCode.attachment.index),
              margin: const EdgeInsets.only(top: P3),
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
              margin: EdgeInsets.only(top: standalone ? P3 : 0),
              leading: SettingsIcon(color: _task.canEditFeatureSets ? null : f3Color),
              value: BaseText(_task.localizedFeatureSets, maxLines: 1),
              onTap: _task.canEditFeatureSets ? () => showFeatureSetsDialog(_controller) : null,
            ),

          /// Набор статусов
          if (_task.canEditProjectStatuses)
            MTField(
              _controller.fData(TaskFCode.statuses.index),
              margin: EdgeInsets.only(top: standalone ? P3 : 0),
              leading: const StatusIcon(),
              value: _task.projectStatuses.isNotEmpty ? BaseText(_controller.projectStatusesController.statusesStr, maxLines: 1) : null,
              onTap: () => showProjectStatusesDialog(_controller.projectStatusesController),
            ),

          /// Связь с источником импорта
          if (_task.didImported)
            MTListTile(
              margin: EdgeInsets.only(top: standalone ? P3 : 0),
              leading: _task.source?.type.icon(size: P5),
              titleText: loc.task_go2source_title,
              trailing: const LinkOutIcon(),
              bottomDivider: false,
              onTap: () => launchUrlString(_task.taskSource!.urlString),
            ),

          if (!_isTaskDialog && _controller.notesController.sortedNotesDates.isNotEmpty) Notes(_controller.notesController),
        ],
      ),
    );
  }
}
