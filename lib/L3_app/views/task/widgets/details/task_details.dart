// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
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
import '../../../../presenters/workspace.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_source.dart';
import '../../../../usecases/task_tree.dart';
import '../../../quiz/abstract_quiz_controller.dart';
import '../../../quiz/quiz_next_button.dart';
import '../../controllers/task_controller.dart';
import '../attachments/attachments.dart';
import '../feature_sets/feature_sets.dart';
import '../notes/notes.dart';
import '../project_statuses/project_statuses.dart';
import '../tasks/task_checklist.dart';
import 'assignee_field.dart';
import 'due_date_field.dart';
import 'start_date_field.dart';
import 'task_status_field.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails(this._controller, {this.qController, this.standalone = false});
  final TaskController _controller;
  final AbstractQuizController? qController;
  final bool standalone;

  bool get _isTaskDialog => isBigScreen && _task.isTask;

  Task get _task => _controller.task!;
  bool get _quizzing => qController?.active == true;
  bool get _showStatusRow => !standalone && !_quizzing && (_task.canShowStatus || _task.canClose || _task.closed);
  bool get _showAssignee => !_isTaskDialog && !_quizzing && _task.canShowAssignee;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView(
        shrinkWrap: true,
        physics: standalone ? null : const NeverScrollableScrollPhysics(),
        children: [
          /// Статус
          if (_showStatusRow) TaskStatusField(_controller),

          /// Назначенный
          if (_showAssignee) TaskAssigneeField(_controller),

          /// Описание
          if (_task.hasDescription || _task.canEdit)
            MTField(
              _controller.fData(TaskFCode.description.index),
              margin: EdgeInsets.only(top: _quizzing || (_showStatusRow && !_showAssignee) ? P : P3),
              leading: DescriptionIcon(color: _task.canEdit ? mainColor : f2Color),
              value: _task.hasDescription
                  ? SelectableLinkify(
                      text: _task.description,
                      style: const BaseText('').style(context),
                      linkStyle: const BaseText('', color: mainColor).style(context),
                      onOpen: (link) async => await launchUrlString(link.url),
                      minLines: 1,
                      maxLines: 20,
                    )
                  : null,
              onTap: _task.canEdit ? _controller.titleController.editDescription : null,
            ),

          /// Кнопка для добавления чек-листа
          if (_task.canAddChecklist)
            MTField(
              MTFieldData(-1, placeholder: '${loc.action_add_title} ${loc.checklist.toLowerCase()}'),
              margin: const EdgeInsets.only(top: P3),
              leading: const PlusCircleIcon(color: mainColor),
              crossAxisAlignment: CrossAxisAlignment.center,
              onTap: () async => await _controller.subtasksController.addTask(),
            ),

          /// Чек-лист
          if (_task.isCheckList) ...[
            const SizedBox(height: P3),
            TaskChecklist(_controller),
          ],

          /// Даты
          if (!_isTaskDialog) ...[
            const SizedBox(height: P3),
            TaskStartDateField(_controller),
            if (_task.hasDueDate || _task.canEdit) TaskDueDateField(_controller),
          ],

          /// Оценки
          if (!_quizzing && _task.canShowEstimate)
            MTField(
              _controller.fData(TaskFCode.estimate.index),
              margin: const EdgeInsets.only(top: P3),
              leading: EstimateIcon(color: _task.canEstimate ? mainColor : f3Color),
              value:
                  _task.hasEstimate ? BaseText('${(_task.openedVolume ?? _task.estimate)?.round()} ${_task.ws.estimateUnitCode}', maxLines: 1) : null,
              onTap: _task.canEstimate ? _controller.estimateController.select : null,
            ),

          /// Вложения
          if (!_quizzing && _task.attachments.isNotEmpty)
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
          if (!_quizzing && _task.canShowFeatureSets)
            MTField(
              _controller.fData(TaskFCode.features.index),
              margin: const EdgeInsets.only(top: P3),
              leading: SettingsIcon(color: _task.canEditFeatureSets ? null : f3Color),
              value: BaseText(_task.localizedFeatureSets, maxLines: 1),
              onTap: _task.canEditFeatureSets ? () => showFeatureSetsDialog(_controller) : null,
            ),

          /// Набор статусов
          if (!_quizzing && _task.canEditProjectStatuses)
            MTField(
              _controller.fData(TaskFCode.statuses.index),
              margin: const EdgeInsets.only(top: P3),
              leading: const StatusIcon(),
              value: _task.projectStatuses.isNotEmpty ? BaseText(_controller.projectStatusesController.statusesStr, maxLines: 1) : null,
              onTap: () => showProjectStatusesDialog(_controller.projectStatusesController),
            ),

          /// Связь с источником импорта
          if (_task.didImported)
            MTListTile(
              margin: const EdgeInsets.only(top: P3),
              leading: _task.source?.type.icon(size: P5),
              titleText: loc.task_go2source_title,
              trailing: const LinkOutIcon(),
              bottomDivider: false,
              onTap: () => launchUrlString(_task.taskSource!.urlString),
            ),

          /// Quiz
          if (_quizzing) QuizNextButton(qController!, disabled: _task.loading),

          if (!_quizzing && _controller.notesController.sortedNotesDates.isNotEmpty) Notes(_controller.notesController),
        ],
      ),
    );
  }
}
