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
import '../task_view_controller.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader({required this.controller, required this.parentContext});
  @protected
  final TaskViewController controller;
  @protected
  final BuildContext parentContext;

  Task get _task => controller.task;
  bool get _hasStatus => _task.status != null;
  bool get _hasAssignee => _task.assignee != null;

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

    return parentsTitles(_task.parent).join(' > ');
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
        H2(_task.title, decoration: _task.closed ? TextDecoration.lineThrough : null),
        if (_hasStatus || _hasAssignee) ...[
          SizedBox(height: onePadding / 3),
          Row(
            children: [
              if (_hasStatus) SmallText(_task.status!.title),
              if (_hasAssignee) ...[
                if (_hasStatus) SizedBox(width: onePadding / 3),
                SmallText('@ ${_task.assignee}'),
              ],
            ],
          ),
        ],
        if (_task.hasLink) ...[
          SizedBox(height: onePadding / 2),
          MTButton(
            '',
            () => launchUrl(_task.taskSource!.uri),
            child: _task.taskSource!.go2SourceTitle(context, showSourceIcon: true),
          ),
        ],
      ]),
    );
  }
}
