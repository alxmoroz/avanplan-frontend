// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/constants.dart';
import '../../components/date_string_widget.dart';
import '../../components/icons.dart';
import '../../components/mt_action.dart';
import '../../components/mt_button.dart';
import '../../components/mt_details_dialog.dart';
import '../../components/mt_divider.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/task_stats_presenter.dart';
import 'task_overview_stats.dart';
import 'task_state_indicator.dart';
import 'task_view_controller.dart';

class TaskOverview extends StatelessWidget {
  TaskViewController get _controller => taskViewController;
  Task get task => _controller.selectedTask;

  bool get hasDescription => task.description.isNotEmpty;
  bool get hasDates => task.dueDate != null || task.etaDate != null;
  bool get hasStatus => task.status != null;
  bool get hasAuthor => task.author != null;
  bool get hasAssignee => task.assignee != null;

  Widget description() => LayoutBuilder(builder: (context, size) {
        final text = task.description;
        final maxLines = task.hasSubtasks ? 3 : 9;
        final detailedTextWidget = LightText(text, maxLines: maxLines);
        final span = TextSpan(text: text, style: detailedTextWidget.style(context));
        final tp = TextPainter(text: span, maxLines: maxLines, textDirection: TextDirection.ltr);
        tp.layout(maxWidth: size.maxWidth);
        final bool hasButton = tp.didExceedMaxLines;
        final divider = MTDivider(color: !hasButton || task.hasSubtasks ? Colors.transparent : null);
        final innerWidget = Column(children: [
          divider,
          Row(children: [
            Expanded(child: detailedTextWidget),
            if (hasButton) Row(children: [SizedBox(width: onePadding / 3), infoIcon(context)]),
          ]),
          divider,
        ]);
        return hasButton ? MTButton('', () => showDetailsDialog(context, task.description), child: innerWidget) : innerWidget;
      });

  Widget buildDates() => Row(children: [
        DateStringWidget(task.dueDate, titleString: loc.task_due_date_label),
        const Spacer(),
        DateStringWidget(task.etaDate, titleString: loc.task_eta_date_label),
      ]);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(onePadding).copyWith(top: 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
        if (hasDescription) description(),
        if (hasAuthor) ...[
          SizedBox(height: onePadding / 3),
          SmallText('/// ${task.author}', align: TextAlign.end),
        ],
        if (hasDates) ...[
          SizedBox(height: onePadding),
          buildDates(),
        ],
        if (!task.closed) ...[
          SizedBox(height: onePadding),
          TaskStateIndicator(task),
        ],
        if (task.hasSubtasks) TaskOverviewStats(task),
        if (_controller.canEdit && (task.isClosable || task.closed)) ...[
          SizedBox(height: onePadding * 2),
          MTAction(
            hint: task.isClosable ? loc.task_state_closable_hint : '',
            title: task.isClosable ? loc.task_state_close_btn_title : loc.task_state_reopen_btn_title,
            icon: task.isClosable ? doneIcon(context, true) : null,
            onPressed: () => _controller.setTaskClosed(context, task, !task.closed),
          ),
        ],
      ]),
    );
  }
}
