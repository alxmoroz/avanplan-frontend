// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../L1_domain/entities_extensions/task_status.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_adaptive.dart';
import '../../../components/mt_button.dart';
import '../../../components/mt_field.dart';
import '../../../components/mt_shadowed.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/person_presenter.dart';
import '../../../presenters/source_presenter.dart';
import '../../../presenters/ws_presenter.dart';
import '../../../usecases/task_available_actions.dart';
import '../controllers/task_controller.dart';
import '../widgets/notes/notes.dart';

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

  bool get _closable => _task.canClose;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTShadowed(
        child: MTAdaptive(
          child: ListView(
            children: [
              if (_task.hasStatus || _closable) ...[
                MTField(
                  controller.fData(TaskFCode.status.index),
                  color: backgroundColor,
                  value: Row(
                    children: [
                      if (_task.hasStatus || _task.canSetStatus)
                        MTButton.main(
                          titleText: '${_task.status}',
                          constrained: false,
                          padding: const EdgeInsets.symmetric(horizontal: P2),
                          margin: const EdgeInsets.only(right: P2),
                          trailing: _task.canSetStatus
                              ? const Padding(
                                  padding: EdgeInsets.only(left: P_3, top: P_6),
                                  child: CaretIcon(size: Size(P * 0.8, P * 0.75), color: darkBackgroundColor),
                                )
                              : null,
                          onTap: _task.canSetStatus ? controller.statusController.selectStatus : null,
                        ),
                      if (_closable)
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
              if (_task.hasAssignee || _task.canAssign) ...[
                MTField(
                  controller.fData(TaskFCode.assignee.index),
                  leading: _task.hasAssignee
                      ? _task.assignee!.icon(P * 1.5)
                      : PersonIcon(
                          size: P3,
                          color: _task.canAssign ? mainColor : lightGreyColor,
                        ),
                  value: _task.hasAssignee ? NormalText('${_task.assignee}', color: _task.canAssign ? null : lightGreyColor) : null,
                  onSelect: _task.canAssign ? controller.assigneeController.assign : null,
                ),
              ],
              if (_task.hasDescription || _task.canUpdate) ...[
                const SizedBox(height: P),
                MTField(
                  controller.fData(TaskFCode.description.index),
                  leading: DescriptionIcon(color: _task.canUpdate ? mainColor : lightGreyColor),
                  value: _task.hasDescription
                      ? SelectableLinkify(
                          text: _task.description,
                          style: const NormalText('').style(context),
                          linkStyle: const NormalText('', color: mainColor).style(context),
                          onOpen: (link) async => await launchUrlString(link.url),
                          // onTap: _task.canUpdate ? controller.editDescription : null,
                        )
                      : null,
                  onSelect: _task.canUpdate ? controller.titleController.editDescription : null,
                ),
              ],
              const SizedBox(height: P),
              controller.datesController.dateField(context, TaskFCode.startDate),
              if (_task.hasDueDate || _task.canUpdate) controller.datesController.dateField(context, TaskFCode.dueDate),
              if (_task.hasEstimate || _task.canEstimate) ...[
                const SizedBox(height: P),
                MTField(
                  controller.fData(TaskFCode.estimate.index),
                  leading: EstimateIcon(color: _task.canEstimate ? mainColor : lightGreyColor),
                  value: _task.hasEstimate ? NormalText('${(_task.openedVolume ?? _task.estimate)?.round()} ${_task.ws.estimateUnitCode}') : null,
                  onSelect: _task.canEstimate ? controller.estimateController.select : null,
                ),
              ],
              if (_task.hasAuthor) ...[
                const SizedBox(height: P),
                MTField(
                  controller.fData(TaskFCode.author.index),
                  leading: _task.author!.icon(P * 1.5),
                  value: NormalText('${_task.author}', color: lightGreyColor),
                  onSelect: null,
                ),
              ],
              if (_task.canComment) ...[
                const SizedBox(height: P),
                MTField(
                  controller.fData(TaskFCode.note.index),
                  value: LightText(
                    controller.fData(TaskFCode.note.index).placeholder,
                    color: lightGreyColor,
                    padding: const EdgeInsets.symmetric(vertical: P_2),
                  ),
                  leading: const NoteAddIcon(),
                  onSelect: controller.notesController.create,
                ),
              ],
              if (controller.notesController.sortedNotesDates.isNotEmpty) ...[
                const SizedBox(height: P),
                Notes(controller.notesController),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
