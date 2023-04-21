// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_level.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/mt_button.dart';
import '../../../components/mt_divider.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/person_presenter.dart';
import '../../../presenters/source_presenter.dart';
import '../../../presenters/task_colors_presenter.dart';
import '../../../presenters/task_level_presenter.dart';
import '../task_view_controller.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader(this.controller);
  @protected
  final TaskViewController controller;

  Task get _task => controller.task;
  bool get _hasStatus => _task.status != null;
  bool get _hasAssignee => _task.assigneeId != null;

  String get _breadcrumbs {
    Iterable<String> parentsTitles(Task? task) {
      final res = <String>[];
      if (task != null && !task.isRoot) {
        if (task.parent != null) {
          res.addAll(parentsTitles(task.parent!));
        }
        res.add(task.name);
      }
      return res;
    }

    return parentsTitles(_task.parent).join(' > ');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_task.bgColor.resolve(context), backgroundColor.resolve(context)],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: P),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (_breadcrumbs.isNotEmpty) ...[
          SmallText(_breadcrumbs),
          const MTDivider(),
        ],
        H2(_task.name, decoration: _task.closed ? TextDecoration.lineThrough : null),
        if (_hasStatus || _hasAssignee) ...[
          const SizedBox(height: P),
          Row(
            children: [
              if (_hasStatus) SmallText(_task.status!.code),
              if (_hasAssignee) ...[
                if (_hasStatus) const SizedBox(width: P_2),
                _task.assignee!.iconName(),
              ],
            ],
          ),
        ],
        if (_task.hasEstimate) ...[
          const SizedBox(height: P_2),
          Row(
            children: [
              SmallText('${loc.task_estimate_placeholder}', color: greyColor),
              SmallText(' ${_task.estimate} ${loc.task_estimate_unit}'),
            ],
          ),
        ],
        if (_task.hasLink)
          MTButton(
            middle: _task.taskSource!.go2SourceTitle(showSourceIcon: true),
            onTap: () => launchUrlString(_task.taskSource!.urlString),
            padding: const EdgeInsets.symmetric(vertical: P_2),
          ),
      ]),
    );
  }
}
