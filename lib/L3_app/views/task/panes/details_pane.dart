// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../L1_domain/entities_extensions/task_status_ext.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_adaptive.dart';
import '../../../components/mt_button.dart';
import '../../../components/mt_field.dart';
import '../../../components/mt_list_tile.dart';
import '../../../components/mt_shadowed.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/date_presenter.dart';
import '../../../presenters/person_presenter.dart';
import '../../../presenters/source_presenter.dart';
import '../../../usecases/task_ext_actions.dart';
import '../task_view_controller.dart';
import '../widgets/notes/task_notes.dart';

class DetailsPane extends StatelessWidget {
  const DetailsPane(this.controller);
  final TaskViewController controller;

  Task get _task => controller.task;

  Widget? get bottomBar => _task.linked
      ? MTButton(
          middle: _task.go2SourceTitle,
          onTap: () => launchUrlString(_task.taskSource!.urlString),
        )
      : null;

  bool get _closable => _task.canClose;

  Widget _dateField(BuildContext context, TaskFCode code) {
    final isStart = code == TaskFCode.startDate;
    final date = isStart ? _task.startDate : _task.dueDate;
    final isEmpty = date == null;
    final fd = controller.fData(code.index);
    return MTField(
      fd,
      leading: isStart ? CalendarIcon(size: P3, color: _task.canUpdate ? mainColor : lightGreyColor) : Container(),
      value: !isEmpty
          ? Row(children: [
              NormalText(date.strMedium, padding: const EdgeInsets.only(right: P_2)),
              LightText(DateFormat.E().format(date), color: greyTextColor),
            ])
          : null,
      onSelect: _task.canUpdate ? () => controller.selectDate(context, code) : null,
      bottomDivider: isStart && (_task.hasDueDate || _task.canUpdate),
      dividerStartIndent: isStart ? P * 5.5 : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTShadowed(
        child: MTAdaptive(
          child: ListView(
            children: [
              if (_task.hasStatus || _closable) ...[
                MTListTile(
                  color: backgroundColor,
                  bottomDivider: false,
                  middle: Row(
                    children: [
                      if (_task.hasStatus || _task.canSetStatus)
                        MTButton.main(
                          titleText: '${_task.status}',
                          constrained: false,
                          padding: const EdgeInsets.symmetric(horizontal: P2),
                          margin: const EdgeInsets.only(right: P2),
                          onTap: _task.canSetStatus ? controller.selectStatus : null,
                        ),
                      if (_closable)
                        MTButton(
                          titleColor: greenColor,
                          titleText: loc.close_action_title,
                          leading: const DoneIcon(true, color: greenColor),
                          onTap: () => controller.setStatus(_task, close: true),
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
                  onSelect: _task.canAssign ? controller.assignPerson : null,
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
                          style: const LightText('').style(context),
                          linkStyle: const NormalText('', color: mainColor).style(context),
                          onOpen: (link) async => await launchUrlString(link.url),
                        )
                      : null,
                  onSelect: _task.canUpdate ? controller.editDescription : null,
                ),
              ],
              const SizedBox(height: P),
              _dateField(context, TaskFCode.startDate),
              if (_task.hasDueDate || _task.canUpdate) _dateField(context, TaskFCode.dueDate),
              if (_task.hasEstimate || _task.canEstimate) ...[
                const SizedBox(height: P),
                MTField(
                  controller.fData(TaskFCode.estimate.index),
                  leading: EstimateIcon(color: _task.canEstimate ? mainColor : lightGreyColor),
                  value: _task.hasEstimate ? NormalText('${_task.sumEstimate} ${loc.task_estimate_unit}') : null,
                  onSelect: _task.canEstimate ? controller.selectEstimate : null,
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
                  leading: const NoteIcon(),
                  onSelect: controller.addNote,
                ),
              ],
              if (controller.sortedNotesDates.isNotEmpty) ...[
                const SizedBox(height: P),
                TaskNotes(controller),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
