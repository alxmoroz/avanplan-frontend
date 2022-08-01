// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_stats.dart';
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
  bool get hasSubtasks => task.tasks.isNotEmpty;

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
        if (hasSubtasks) TaskOverviewStats(task),
      ]),
    );
  }
}
