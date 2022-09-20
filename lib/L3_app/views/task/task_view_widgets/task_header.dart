// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_ext_level.dart';
import '../../../../L1_domain/entities/task_ext_state.dart';
import '../../../components/constants.dart';
import '../../../components/mt_button.dart';
import '../../../components/mt_divider.dart';
import '../../../components/text_widgets.dart';
import '../../../presenters/task_source_presenter.dart';
import '../task_related_widgets/task_state_indicator.dart';
import '../task_view_controller.dart';
import 'task_time_chart.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader({required this.controller, required this.parentContext});
  final TaskViewController controller;
  final BuildContext parentContext;
  Task get task => controller.task;

  bool get _hasStatus => task.status != null;
  bool get _hasAssignee => task.assignee != null;
  bool get _showTimeChart => !task.closed && (task.hasDueDate || task.hasEtaDate);

  String get _breadcrumbs {
    Iterable<String> parentsTitles(Task? task) {
      final res = <String>[];
      if (task != null && !task.isWorkspace) {
        if (task.parent != null) {
          res.addAll(parentsTitles(task.parent!));
        }
        res.add(task.title);
      }
      return res;
    }

    return parentsTitles(task.parent).join(' > ');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(onePadding).copyWith(bottom: 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (_breadcrumbs.isNotEmpty) ...[
          SmallText(_breadcrumbs),
          const MTDivider(),
        ],
        H2(task.title, decoration: task.closed ? TextDecoration.lineThrough : null),
        if (_hasStatus || _hasAssignee) ...[
          SizedBox(height: onePadding / 3),
          Row(
            children: [
              if (_hasStatus) SmallText(task.status!.title),
              if (_hasAssignee) ...[
                if (_hasStatus) SizedBox(width: onePadding / 3),
                SmallText('@ ${task.assignee}'),
              ],
            ],
          ),
        ],
        if (task.showState) ...[
          SizedBox(height: onePadding / 3),
          TaskStateIndicator(task),
        ],
        if (_showTimeChart) ...[
          SizedBox(height: onePadding / 3),
          TaskTimeChart(task),
        ],
        if (task.hasLink) ...[
          SizedBox(height: onePadding / 2),
          MTButton(
            '',
            () => launchUrl(task.taskSource!.uri),
            child: task.taskSource!.go2SourceTitle(context, showSourceIcon: true),
          ),
        ],
      ]),
    );
  }
}
