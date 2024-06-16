// Copyright (c) 2024. Alexandr Moroz

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
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/feature_set.dart';
import '../../../../presenters/source.dart';
import '../../../../usecases/project_features.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_source.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../attachments/attachment_list_dialog.dart';
import '../features/features.dart';
import '../notes/notes.dart';
import '../tasks/task_checklist.dart';
import 'assignee_field.dart';
import 'description_field.dart';
import 'due_date_field.dart';
import 'estimate_field.dart';
import 'start_date_field.dart';
import 'task_status_field.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails(this._controller, {super.key, this.standalone = false, this.compact = false});
  final TaskController _controller;
  final bool standalone;
  final bool compact;

  Task get _task => _controller.task;

  bool _isTaskDialog(BuildContext context) => isBigScreen(context) && _task.isTask;
  bool _isTaskMobileView(BuildContext context) => !isBigScreen(context) && _task.isTask;
  bool _showStatusRow(BuildContext context) => _isTaskMobileView(context) && (_task.canShowStatus || _task.closed);
  bool _showDescription(BuildContext context) => !_isTaskDialog(context) && (_task.hasDescription || _task.canEdit);

  bool _hasMargins(BuildContext context) => standalone || _isTaskMobileView(context);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView(
        shrinkWrap: true,
        physics: standalone ? null : const NeverScrollableScrollPhysics(),
        children: [
          /// Статус
          if (_showStatusRow(context)) ...[
            const SizedBox(height: P),
            TaskStatusField(_controller),
          ],

          /// Описание
          if (_showDescription(context)) TaskDescriptionField(_controller, compact: compact, hasMargin: _hasMargins(context)),

          /// Чек-лист
          if (!_isTaskDialog(context) && (_task.canCreateChecklist || _task.isCheckList)) ...[
            const SizedBox(height: P3),
            TaskChecklist(_controller),
          ],

          /// Назначенный
          if (_task.canShowAssignee) TaskAssigneeField(_controller, compact: compact, hasMargin: _hasMargins(context)),

          /// Даты
          if (!_task.isInbox) TaskStartDateField(_controller, compact: compact, hasMargin: _hasMargins(context)),
          if (_task.hasDueDate || _task.canEdit) TaskDueDateField(_controller, compact: compact, hasMargin: _hasMargins(context)),

          /// Оценки
          if (_task.hfEstimates && (!_task.closed || _task.hasEstimate))
            TaskEstimateField(_controller, compact: compact, hasMargin: _hasMargins(context)),

          /// Вложения
          if (!_isTaskDialog(context) && _task.attachments.isNotEmpty)
            MTField(
              _controller.fData(TaskFCode.attachment.index),
              margin: EdgeInsets.only(top: _hasMargins(context) ? P3 : 0),
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
              onTap: () => attachmentsDialog(_controller.attachmentsController),
            ),

          /// FeatureSets
          if (_task.canShowFeatureSets)
            MTField(
              _controller.fData(TaskFCode.features.index),
              margin: EdgeInsets.only(top: _hasMargins(context) ? P3 : 0),
              leading: SettingsIcon(color: _task.canEditFeatureSets ? mainColor : f3Color),
              value: BaseText(_task.localizedFeatureSets, maxLines: 1),
              compact: compact,
              onTap: _task.canEditFeatureSets ? () => projectFeaturesDialog(_controller) : null,
            ),

          /// Связь с источником импорта
          if (_task.didImported)
            MTListTile(
              margin: EdgeInsets.only(top: _hasMargins(context) ? P3 : 0),
              leading: _task.source?.type.icon(size: P6),
              titleText: !compact ? loc.task_go2source_title : null,
              trailing: !compact ? const LinkOutIcon() : null,
              bottomDivider: false,
              onTap: () => launchUrlString(_task.taskSource!.urlString),
            ),

          /// Комментарии
          if (_isTaskMobileView(context) && _controller.notesController.sortedNotesDates.isNotEmpty) Notes(_controller),
        ],
      ),
    );
  }
}
