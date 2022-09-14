// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_ext_level.dart';
import '../../../../L1_domain/entities/task_ext_state.dart';
import '../../../components/constants.dart';
import '../../../components/date_string_widget.dart';
import '../../../components/mt_button.dart';
import '../../../components/mt_divider.dart';
import '../../../components/mt_progress.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/number_presenter.dart';
import '../../../presenters/task_overview_presenter.dart';
import '../../../presenters/task_source_presenter.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader(this.task);
  final Task task;

  bool get hasStatus => task.status != null;
  bool get hasAssignee => task.assignee != null;
  bool get hasDates => task.hasDueDate || task.hasEtaDate;

  // TODO: виджет
  String get breadcrumbs {
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

  Widget buildDates() => Row(children: [
        DateStringWidget(task.dueDate, titleString: loc.task_due_date_label),
        const Spacer(),
        DateStringWidget(task.etaDate, titleString: loc.task_eta_date_label),
      ]);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(onePadding).copyWith(bottom: 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (breadcrumbs.isNotEmpty) ...[
          SmallText(breadcrumbs),
          const MTDivider(),
        ],
        H2(task.title, decoration: task.closed ? TextDecoration.lineThrough : null),
        if (task.hasLink) ...[
          SizedBox(height: onePadding / 2),
          MTButton(
            '',
            () => launchUrl(task.taskSource!.uri),
            child: task.taskSource!.go2SourceTitle(context, showSourceIcon: true),
          ),
        ],
        if (hasStatus || hasAssignee) ...[
          SizedBox(height: onePadding / 2),
          Row(
            children: [
              if (hasStatus) SmallText(task.status!.title),
              if (hasAssignee) ...[
                SizedBox(width: onePadding / 2),
                SmallText('@ ${task.assignee}'),
              ],
            ],
          ),
        ],
        if (hasDates) ...[
          SizedBox(height: onePadding / 2),
          buildDates(),
        ],
        if (task.hasDueDate) ...[
          SizedBox(height: onePadding / 2),
          SampleProgress(
            ratio: task.doneRatio,
            color: task.stateColor,
            titleText: loc.task_state_closed,
            trailingText: task.doneRatio.inPercents,
          ),
        ],
      ]),
    );
  }
}
