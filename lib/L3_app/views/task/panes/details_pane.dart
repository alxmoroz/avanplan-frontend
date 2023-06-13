// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../L1_domain/entities_extensions/task_stats.dart';
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
import '../../../usecases/task_ext_refs.dart';
import '../task_view_controller.dart';

class DetailsPane extends StatelessWidget {
  const DetailsPane(this.controller);
  final TaskViewController controller;

  Task get _task => controller.task;

  Widget? get bottomBar => _task.hasLink
      ? MTButton(
          middle: _task.taskSource!.go2SourceTitle(showSourceIcon: true),
          onTap: () => launchUrlString(_task.taskSource!.urlString),
        )
      : null;

  bool get _closable => _task.canCloseGroup || _task.canCloseLeaf;

  Widget get _assignee => _task.assignee!.iconName();

  Widget _description(BuildContext context) {
    return MTListTile(
      middle: SelectableLinkify(
        text: _task.description,
        style: const LightText('').style(context),
        linkStyle: const NormalText('', color: mainColor).style(context),
        onOpen: (link) async => await launchUrlString(link.url),
      ),
      bottomDivider: false,
    );
  }

  Widget _dateField(BuildContext context, String code) {
    final isStart = code == 'startDate';
    final date = isStart ? _task.startDate : _task.dueDate;
    final isEmpty = date == null;
    return MTField(
      controller.fData(code),
      leading: isStart ? const CalendarIcon(size: P3) : null,
      value: !isEmpty
          ? Row(children: [
              NormalText(date.strMedium, padding: const EdgeInsets.only(right: P_2)),
              LightText(DateFormat.E().format(date), color: greyColor),
            ])
          : null,
      onSelect: () => controller.selectDate(code),
      onReset: () => controller.resetDate(code),
      bottomDivider: isStart,
      dividerStartIndent: isStart ? P * 6 : null,
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
                const SizedBox(height: P),
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
                          onTap: _task.canSetStatus ? controller.selectStatus : null,
                        ),
                      if (_closable)
                        MTButton(
                          titleColor: greenColor,
                          titleText: loc.close_action_title,
                          leading: const DoneIcon(true, color: greenColor),
                          margin: const EdgeInsets.only(left: P2),
                          onTap: () => controller.setStatus(_task, close: true),
                        )
                    ],
                  ),
                ),
              ],
              if (_task.hasAssignee) ...[
                const SizedBox(height: P),
                // _task.canUpdate ? MTButton.secondary(middle: _assignee) :
                MTListTile(
                  leading: LightText(loc.task_assignee_placeholder, color: lightGreyColor),
                  middle: _assignee,
                ),
              ],
              if (_task.hasDescription) ...[
                const SizedBox(height: P),
                _description(context),
              ],
              const SizedBox(height: P),
              _dateField(context, 'startDate'),
              _dateField(context, 'dueDate'),
              if (_task.hasEstimate || _task.canEstimate) ...[
                const SizedBox(height: P),
                MTField(
                  controller.fData('estimate'),
                  leading: EstimateIcon(size: P3, color: _task.canEstimate ? mainColor : lightGreyColor),
                  value: _task.hasEstimate ? NormalText('${_task.estimate} ${loc.task_estimate_unit}') : null,
                  onSelect: _task.canEstimate ? controller.selectEstimate : null,
                  onReset: _task.canEstimate ? controller.resetEstimate : null,
                ),
              ],
              if (_task.hasAuthor) ...[
                const SizedBox(height: P),
                MTField(
                  controller.fData('author'),
                  leading: _task.author!.icon(P * 1.5),
                  value: NormalText('${_task.author}'),
                  onSelect: null,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
