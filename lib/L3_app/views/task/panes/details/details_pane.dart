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
import '../../../../components/shadowed.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/person.dart';
import '../../../../presenters/project_feature_set.dart';
import '../../../../presenters/task_source.dart';
import '../../../../presenters/workspace.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_feature_sets.dart';
import '../../controllers/task_controller.dart';
import 'feature_sets.dart';
import 'notes/notes.dart';

class DetailsPane extends StatelessWidget {
  const DetailsPane(this.controller);
  final TaskController controller;

  Task get _task => controller.task;

  Widget? get bottomBar => _task.linked
      ? MTButton(
          middle: _task.go2SourceTitle,
          onTap: () => launchUrlString(_task.taskSource!.urlString),
        )
      : null;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTShadowed(
        topPaddingIndent: 0,
        child: MTAdaptive(
          child: ListView(
            children: [
              if (_task.hasStatus) ...[
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
              ],
              if (_task.hfsTeam && (_task.hasAssignee || _task.canAssign)) ...[
                SizedBox(height: _task.hasStatus ? P : P3),
                MTField(
                  controller.fData(TaskFCode.assignee.index),
                  leading: _task.hasAssignee
                      ? _task.assignee!.icon(P3, borderColor: mainColor)
                      : PersonIcon(
                          color: _task.canAssign ? mainColor : f2Color,
                        ),
                  value: _task.hasAssignee ? BaseText('${_task.assignee}', color: _task.canAssign ? null : f2Color) : null,
                  onSelect: _task.canAssign ? controller.assigneeController.assign : null,
                ),
              ],
              if (_task.hasDescription || _task.canEdit) ...[
                const SizedBox(height: P3),
                MTField(
                  controller.fData(TaskFCode.description.index),
                  leading: DescriptionIcon(color: _task.canEdit ? mainColor : f2Color),
                  value: _task.hasDescription
                      ? SelectableLinkify(
                          text: _task.description,
                          style: const BaseText('').style(context),
                          linkStyle: const BaseText('', color: mainColor).style(context),
                          onOpen: (link) async => await launchUrlString(link.url),
                          // onTap: _task.canUpdate ? controller.editDescription : null,
                        )
                      : null,
                  onSelect: _task.canEdit ? controller.titleController.editDescription : null,
                ),
              ],
              const SizedBox(height: P3),
              controller.datesController.dateField(context, TaskFCode.startDate),
              if (_task.hasDueDate || _task.canEdit) controller.datesController.dateField(context, TaskFCode.dueDate),
              if (_task.hfsEstimates && (_task.hasEstimate || _task.canEstimate)) ...[
                const SizedBox(height: P3),
                MTField(
                  controller.fData(TaskFCode.estimate.index),
                  leading: EstimateIcon(color: _task.canEstimate ? mainColor : f3Color),
                  value: _task.hasEstimate ? BaseText('${(_task.openedVolume ?? _task.estimate)?.round()} ${_task.ws.estimateUnitCode}') : null,
                  onSelect: _task.canEstimate ? controller.estimateController.select : null,
                ),
              ],
              if (_task.hfsTeam && _task.hasAuthor) ...[
                const SizedBox(height: P3),
                MTField(
                  controller.fData(TaskFCode.author.index),
                  leading: _task.author!.icon(P3, borderColor: f3Color),
                  value: BaseText('${_task.author}', color: f2Color),
                  onSelect: null,
                ),
              ],
              if (controller.onbController.onboarding)
                MTButton.main(
                  titleText: loc.project_feature_sets_select_action_title,
                  margin: const EdgeInsets.symmetric(vertical: P3),
                  onTap: () => showFeatureSetsDialog(controller),
                )
              else if (_task.canViewFeatureSets) ...[
                const SizedBox(height: P3),
                MTField(
                  controller.fData(TaskFCode.features.index),
                  leading: SettingsIcon(color: _task.canEditFeatureSets ? null : f3Color),
                  value: BaseText(_task.localizedFeatureSets, maxLines: 1),
                  onSelect: _task.canEditFeatureSets ? () => showFeatureSetsDialog(controller) : null,
                ),
              ],
              if (_task.canComment) ...[
                const SizedBox(height: P3),
                MTField(
                  controller.fData(TaskFCode.note.index),
                  value: BaseText(
                    controller.fData(TaskFCode.note.index).placeholder,
                    color: f2Color,
                    padding: const EdgeInsets.symmetric(vertical: P),
                  ),
                  leading: const NoteAddIcon(),
                  onSelect: controller.notesController.create,
                ),
              ],
              if (controller.notesController.sortedNotesDates.isNotEmpty) ...[
                const SizedBox(height: P3),
                Notes(controller.notesController),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
