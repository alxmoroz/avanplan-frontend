// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_stats.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/date_string_widget.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_details_dialog.dart';
import '../../components/mt_divider.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'task_overview_stats.dart';
import 'task_state_indicator.dart';

class TaskOverview extends StatelessWidget {
  const TaskOverview(this.task);

  final Task task;

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
        final divider = MTDivider(color: !hasButton ? Colors.transparent : null);
        final innerWidget = Column(children: [
          divider,
          Row(children: [
            Expanded(child: detailedTextWidget),
            if (hasButton) Row(children: [SizedBox(width: onePadding / 2), infoIcon(context)]),
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
      padding: EdgeInsets.all(onePadding),
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
          SizedBox(height: onePadding / 2),
          buildDates(),
        ],
        SizedBox(height: onePadding),
        TaskStateIndicator(task),
        if (task.hasSubtasks) TaskOverviewStats(task),
        if (task.isClosable || task.closed) ...[
          SizedBox(height: onePadding * 2),
          if (task.isClosable) ...[
            LightText(loc.task_state_closable_hint, align: TextAlign.center),
            SizedBox(height: onePadding),
          ],
          MTButton(
            null,
            () => taskViewController.setTaskClosed(context, task, !task.closed),
            child: Row(
              children: [
                const Spacer(),
                if (task.isClosable) doneIcon(context, true),
                SizedBox(width: onePadding / 2),
                H4(task.isClosable ? loc.task_state_close_btn_title : loc.task_state_reopen_btn_title, color: mainColor),
                const Spacer(),
              ],
            ),
          ),
        ],
      ]),
    );
  }
}
