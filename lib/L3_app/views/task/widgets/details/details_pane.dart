// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/feature_set.dart';
import '../../../../presenters/person.dart';
import '../../../../presenters/source.dart';
import '../../../../presenters/workspace.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_feature_sets.dart';
import '../../../../usecases/task_source.dart';
import '../../../../usecases/task_status.dart';
import '../../../../usecases/task_tree.dart';
import '../../../quiz/next_button.dart';
import '../../../quiz/quiz_controller.dart';
import '../../controllers/task_controller.dart';
import '../attachments/attachments.dart';
import '../feature_sets/feature_sets.dart';
import '../notes/notes.dart';
import '../project_statuses/project_statuses.dart';

class DetailsPane extends StatelessWidget {
  const DetailsPane(this.controller, {this.qController});
  final TaskController controller;
  final QuizController? qController;

  Task get _task => controller.task;
  bool get _quizzing => qController?.active == true;
  bool get _showStatusRow => _task.hasStatus || (_task.isTask);
  bool get _showAssignee => !_quizzing && _task.hfsTeam && (_task.hasAssignee || _task.canAssign);

  MTFieldData get _statusFD => controller.fData(TaskFCode.status.index);

  Widget? get bottomBar => null;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTShadowed(
        topPaddingIndent: 0,
        bottomPaddingIndent: P3,
        child: MTAdaptive(
          child: ListView(
            children: [
              /// Статус
              if (_showStatusRow)
                MTField(
                  _statusFD,
                  minHeight: MIN_BTN_HEIGHT,
                  value: Row(
                    children: [
                      if (_task.canShowStatus)
                        MTButton.main(
                          titleText: '${_task.status}',
                          color: _task.closed ? greenColor : null,
                          constrained: false,
                          padding: const EdgeInsets.symmetric(horizontal: P4),
                          margin: const EdgeInsets.only(right: P2),
                          trailing: _task.canSetStatus
                              ? const Padding(
                                  padding: EdgeInsets.only(left: P_2, top: P_2),
                                  child: CaretIcon(size: Size(P2 * 0.8, P2 * 0.75), color: mainBtnTitleColor),
                                )
                              : null,
                          onTap: _task.canSetStatus ? controller.statusController.selectStatus : null,
                        ),
                      if (_task.canClose)
                        MTButton(
                          titleColor: greenColor,
                          titleText: loc.close_action_title,
                          leading: const DoneIcon(true, color: greenColor),
                          onTap: () => controller.statusController.setStatus(_task, close: true),
                        )
                      else if (_task.closed)
                        MTButton(
                          titleText: loc.state_closed,
                          type: ButtonType.card,
                          color: greenLightColor,
                          titleColor: greenColor,
                          padding: const EdgeInsets.symmetric(horizontal: P3),
                        ),
                    ],
                  ),
                  color: b2Color,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),

              /// Назначенный
              if (_showAssignee) ...[
                MTField(
                  controller.fData(TaskFCode.assignee.index),
                  margin: EdgeInsets.only(top: _showStatusRow ? P : P3),
                  leading: _task.hasAssignee
                      ? _task.assignee!.icon(P3, borderColor: mainColor)
                      : PersonIcon(
                          color: _task.canAssign ? mainColor : f2Color,
                        ),
                  value: _task.hasAssignee ? BaseText('${_task.assignee}', color: _task.canAssign ? null : f2Color, maxLines: 1) : null,
                  onTap: _task.canAssign ? controller.assigneeController.startAssign : null,
                ),
              ],

              /// Описание
              if (_task.hasDescription || _task.canEdit)
                MTField(
                  controller.fData(TaskFCode.description.index),
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
                  onTap: _task.canEdit ? controller.titleController.editDescription : null,
                ),

              /// Даты
              const SizedBox(height: P3),
              controller.datesController.dateField(context, TaskFCode.startDate),
              if (_task.hasDueDate || _task.canEdit) controller.datesController.dateField(context, TaskFCode.dueDate),

              /// Кнопка для добавления Чек-листа
              if (_task.canAddChecklist)
                MTField(
                  MTFieldData(-1, placeholder: '${loc.action_add_title} ${loc.checklist.toLowerCase()}'),
                  margin: const EdgeInsets.only(top: P3),
                  leading: const TasksIcon(size: P6, color: mainColor),
                  crossAxisAlignment: CrossAxisAlignment.center,
                  onTap: () async => await controller.subtasksController.addTask(),
                ),

              /// Оценки
              if (!_quizzing && _task.hfsEstimates && (_task.hasEstimate || _task.canEstimate))
                MTField(
                  controller.fData(TaskFCode.estimate.index),
                  margin: const EdgeInsets.only(top: P3),
                  leading: EstimateIcon(color: _task.canEstimate ? mainColor : f3Color),
                  value: _task.hasEstimate
                      ? BaseText('${(_task.openedVolume ?? _task.estimate)?.round()} ${_task.ws.estimateUnitCode}', maxLines: 1)
                      : null,
                  onTap: _task.canEstimate ? controller.estimateController.select : null,
                ),

              /// Вложения
              if (!_quizzing && _task.attachments.isNotEmpty)
                MTField(
                  controller.fData(TaskFCode.attachment.index),
                  margin: const EdgeInsets.only(top: P3),
                  leading: const AttachmentIcon(),
                  value: Row(children: [
                    Flexible(child: BaseText(controller.attachmentsController.attachmentsStr, maxLines: 1)),
                    if (controller.attachmentsController.attachmentsCountMoreStr.isNotEmpty)
                      BaseText.f2(
                        controller.attachmentsController.attachmentsCountMoreStr,
                        maxLines: 1,
                        padding: const EdgeInsets.only(left: P),
                      )
                  ]),
                  onTap: () => showAttachmentsDialog(controller.attachmentsController),
                ),

              /// Author
              if (!_quizzing && _task.hfsTeam && _task.author != null)
                MTField(
                  controller.fData(TaskFCode.author.index),
                  margin: const EdgeInsets.only(top: P3),
                  leading: _task.author!.icon(P3, borderColor: f3Color),
                  value: BaseText.f2('${_task.author}', maxLines: 1),
                ),

              /// FeatureSets
              if (!_quizzing && _task.canViewFeatureSets)
                MTField(
                  controller.fData(TaskFCode.features.index),
                  margin: const EdgeInsets.only(top: P3),
                  leading: SettingsIcon(color: _task.canEditFeatureSets ? null : f3Color),
                  value: BaseText(_task.localizedFeatureSets, maxLines: 1),
                  onTap: _task.canEditFeatureSets ? () => showFeatureSetsDialog(controller) : null,
                ),

              /// Набор статусов
              if (!_quizzing && _task.canEditProjectStatuses)
                MTField(
                  controller.fData(TaskFCode.statuses.index),
                  margin: const EdgeInsets.only(top: P3),
                  leading: const StatusIcon(),
                  value: _task.projectStatuses.isNotEmpty ? BaseText(controller.projectStatusesController.statusesStr, maxLines: 1) : null,
                  onTap: () => showProjectStatusesDialog(controller.projectStatusesController),
                ),

              /// Связь с источником импорта
              if (_task.didImported)
                MTListTile(
                  margin: const EdgeInsets.only(top: P3),
                  leading: _task.source?.type.icon(size: P6),
                  titleText: loc.task_go2source_title,
                  trailing: const LinkOutIcon(),
                  bottomDivider: false,
                  onTap: () => launchUrlString(_task.taskSource!.urlString),
                ),

              /// Quiz
              if (_quizzing) QuizNextButton(qController!, disabled: _task.loading),

              /// Notes
              if (!_quizzing && _task.canComment)
                MTField(
                  controller.fData(TaskFCode.note.index),
                  margin: const EdgeInsets.only(top: P3),
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // value: BaseText.f2(controller.fData(TaskFCode.note.index).placeholder, maxLines: 1),
                  leading: const NoteAddIcon(),
                  onTap: controller.notesController.create,
                ),

              if (!_quizzing && controller.notesController.sortedNotesDates.isNotEmpty) Notes(controller.notesController),
            ],
          ),
        ),
      ),
    );
  }
}
