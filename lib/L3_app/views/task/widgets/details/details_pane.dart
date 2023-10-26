// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../../L1_domain/entities_extensions/task_status.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/feature_set.dart';
import '../../../../presenters/person.dart';
import '../../../../presenters/source.dart';
import '../../../../presenters/task_source.dart';
import '../../../../presenters/workspace.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_feature_sets.dart';
import '../../../quiz/next_button.dart';
import '../../controllers/create_project_quiz_controller.dart';
import '../../controllers/task_controller.dart';
import '../feature_sets/feature_sets.dart';
import 'attachments.dart';
import 'notes.dart';

class DetailsPane extends StatelessWidget {
  const DetailsPane(this.controller, {this.qController});
  final TaskController controller;
  final CreateProjectQuizController? qController;

  Task get _task => controller.task;
  bool get _quizzing => qController?.active == true;

  Widget? get bottomBar => null;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTShadowed(
        topPaddingIndent: 0,
        child: MTAdaptive(
          child: ListView(
            children: [
              /// Статус
              if (_task.hasStatus)
                MTField(
                  controller.fData(TaskFCode.status.index),
                  color: b2Color,
                  value: Row(
                    children: [
                      if (_task.hasStatus || _task.canSetStatus)
                        MTButton.main(
                          titleText: '${_task.status}',
                          constrained: false,
                          padding: const EdgeInsets.symmetric(horizontal: P4),
                          margin: const EdgeInsets.only(right: P3),
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
                    ],
                  ),
                ),

              /// Назначенный
              if (!_quizzing && _task.hfsTeam && (_task.hasAssignee || _task.canAssign)) ...[
                MTField(
                  controller.fData(TaskFCode.assignee.index),
                  margin: EdgeInsets.only(top: _task.hasStatus ? P : P3),
                  leading: _task.hasAssignee
                      ? _task.assignee!.icon(P3, borderColor: mainColor)
                      : PersonIcon(
                          color: _task.canAssign ? mainColor : f2Color,
                        ),
                  value: _task.hasAssignee ? BaseText('${_task.assignee}', color: _task.canAssign ? null : f2Color) : null,
                  onSelect: _task.canAssign ? controller.assigneeController.assign : null,
                ),
              ],

              /// Описание
              if (_task.hasDescription || _task.canEdit)
                MTField(
                  controller.fData(TaskFCode.description.index),
                  margin: EdgeInsets.only(top: _quizzing ? P : P3),
                  leading: DescriptionIcon(color: _task.canEdit ? mainColor : f2Color),
                  value: _task.hasDescription
                      ? SelectableLinkify(
                          text: _task.description,
                          style: const BaseText('').style(context),
                          linkStyle: const BaseText('', color: mainColor).style(context),
                          onOpen: (link) async => await launchUrlString(link.url),
                          minLines: 1,
                          maxLines: 10,
                        )
                      : null,
                  onSelect: _task.canEdit ? controller.titleController.editDescription : null,
                ),

              /// Даты
              const SizedBox(height: P3),
              controller.datesController.dateField(context, TaskFCode.startDate),
              if (_task.hasDueDate || _task.canEdit) controller.datesController.dateField(context, TaskFCode.dueDate),

              /// Оценки
              if (!_quizzing && _task.hfsEstimates && (_task.hasEstimate || _task.canEstimate))
                MTField(
                  controller.fData(TaskFCode.estimate.index),
                  margin: const EdgeInsets.only(top: P3),
                  leading: EstimateIcon(color: _task.canEstimate ? mainColor : f3Color),
                  value: _task.hasEstimate ? BaseText('${(_task.openedVolume ?? _task.estimate)?.round()} ${_task.ws.estimateUnitCode}') : null,
                  onSelect: _task.canEstimate ? controller.estimateController.select : null,
                ),

              /// Вложения
              if (!_quizzing && _task.attachments.isNotEmpty)
                MTField(
                  controller.fData(TaskFCode.attachment.index),
                  margin: const EdgeInsets.only(top: P3),
                  leading: const AttachmentIcon(),
                  value: Row(children: [
                    Expanded(child: BaseText(controller.attachmentsController.attachmentsStr, maxLines: 1)),
                    if (controller.attachmentsController.attachmentsCountMoreStr.isNotEmpty)
                      BaseText.f2(controller.attachmentsController.attachmentsCountMoreStr)
                  ]),
                  onSelect: () => showAttachmentsDialog(controller.attachmentsController),
                ),

              /// Author
              if (!_quizzing && _task.hfsTeam && _task.hasAuthor)
                MTField(
                  controller.fData(TaskFCode.author.index),
                  margin: const EdgeInsets.only(top: P3),
                  leading: _task.author!.icon(P3, borderColor: f3Color),
                  value: BaseText.f2('${_task.author}'),
                ),

              /// FeatureSets
              if (!_quizzing && _task.canViewFeatureSets)
                MTField(
                  controller.fData(TaskFCode.features.index),
                  margin: const EdgeInsets.only(top: P3),
                  leading: SettingsIcon(color: _task.canEditFeatureSets ? null : f3Color),
                  value: BaseText(_task.localizedFeatureSets, maxLines: 1),
                  onSelect: _task.canEditFeatureSets ? () => showFeatureSetsDialog(controller) : null,
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
                  value: BaseText.f2(
                    controller.fData(TaskFCode.note.index).placeholder,
                    padding: const EdgeInsets.symmetric(vertical: P),
                  ),
                  leading: const NoteAddIcon(),
                  onSelect: controller.notesController.create,
                ),

              if (!_quizzing && controller.notesController.sortedNotesDates.isNotEmpty) Notes(controller.notesController),
            ],
          ),
        ),
      ),
    );
  }
}
