// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/constants.dart';
import '../../components/date_string_widget.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_details_dialog.dart';
import '../../components/mt_divider.dart';
import '../../components/mt_progress.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/number_presenter.dart';
import '../../presenters/task_overview_presenter.dart';
import 'task_state_indicator.dart';

class TaskOverview extends StatelessWidget {
  const TaskOverview(this.task);

  final Task task;

  bool get hasDescription => task.description.isNotEmpty;
  bool get hasLink => task.trackerId != null;
  bool get hasDates => task.dueDate != null || task.etaDate != null;
  bool get isClosed => task.closed;
  bool get hasStatus => task.status != null;
  bool get hasSubtasks => task.leafTasksCount > 0;

  Widget description() => LayoutBuilder(builder: (context, size) {
        final text = task.description;
        final maxLines = task.leafTasksCount > 0 ? 3 : 9;
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
        if (task.leftTasksCount > 0) DateStringWidget(task.etaDate, titleString: loc.task_eta_date_label),
      ]);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(onePadding),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (hasStatus) ...[
          SizedBox(height: onePadding / 2),
          SmallText(task.status!.title),
        ],
        if (hasDescription) description(),
        if (hasDates) ...[
          SizedBox(height: onePadding / 2),
          buildDates(),
        ],
        SizedBox(height: onePadding),
        TaskStateIndicator(task),
        if (hasSubtasks) ...[
          SizedBox(height: onePadding / 2),
          SampleProgress(
            ratio: task.doneRatio,
            color: stateColor(task.overallState),
            titleText: loc.task_list_title_count(task.leafTasksCount),
            trailingText: task.doneRatio > 0 ? task.doneRatio.inPercents : '',
          ),
        ]
      ]),
    );
  }
}
