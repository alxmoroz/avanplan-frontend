// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/goals/task.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/date_string_widget.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_card.dart';
import '../../components/mt_details_dialog.dart';
import '../../components/mt_divider.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../_base/smartable_progress_widget.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({required this.task, this.onTapHeader, this.detailedScreen = false, this.onTapFooter});

  final Task task;
  final bool detailedScreen;
  final VoidCallback? onTapHeader;
  final VoidCallback? onTapFooter;

  bool get hasDescription => task.description.isNotEmpty;
  bool get hasLink => task.trackerId != null;
  bool get hasDates => task.dueDate != null || task.etaDate != null;
  bool get hasSubtasks => task.tasksCount > 0;
  bool get hasStatus => task.status != null;
  bool get isClosed => task.closed;
  bool get hasFooter => hasDates || hasSubtasks || hasStatus || hasLink || isClosed;

  Widget title(BuildContext context) => MediumText(
        task.title,
        color: darkGreyColor,
        maxLines: detailedScreen ? 3 : 2,
        sizeScale: detailedScreen ? 1.25 : 1,
        decoration: task.closed ? TextDecoration.lineThrough : null,
      );

  Widget headerTrailing(BuildContext context) {
    return Row(children: [
      SizedBox(width: onePadding / 2),
      detailedScreen ? editIcon(context) : chevronIcon(context),
    ]);
  }

  Widget header(BuildContext context) {
    return MTButton(
      '',
      detailedScreen ? onTapHeader : null,
      child: Row(children: [
        Expanded(child: title(context)),
        headerTrailing(context),
      ]),
    );
  }

  Widget description() => LayoutBuilder(builder: (context, size) {
        final text = task.description;
        final maxLines = detailedScreen ? 5 : 3;
        final detailedTextWidget = LightText(text, maxLines: maxLines);
        final listTextWidget = SmallText(text, maxLines: maxLines, weight: FontWeight.w300);
        final span = TextSpan(text: text, style: detailedScreen ? detailedTextWidget.style(context) : listTextWidget.style(context));
        final tp = TextPainter(text: span, maxLines: maxLines, textDirection: TextDirection.ltr);
        tp.layout(maxWidth: size.maxWidth);
        final bool hasButton = tp.didExceedMaxLines && detailedScreen;
        final divider = MTDivider(
          color: hasButton ? darkGreyColor : Colors.transparent,
          height: detailedScreen ? onePadding : onePadding / 4,
        );
        final innerWidget = Column(children: [
          divider,
          Row(children: [
            Expanded(child: detailedScreen ? detailedTextWidget : listTextWidget),
            if (hasButton) Row(children: [SizedBox(width: onePadding / 2), infoIcon(context)]),
          ]),
          if (hasFooter) divider,
        ]);
        return hasButton ? MTButton('', () => showDetailsDialog(context, task.description), child: innerWidget) : innerWidget;
      });

  Widget status() => SmallText(task.status!.title, weight: FontWeight.w500);

  Widget closedProgressCount() => Row(children: [
        SmallText('${loc.common_mark_done_btn_title} ', weight: FontWeight.w300),
        SmallText('${task.closedTasksCount} / ${task.tasksCount}', weight: FontWeight.w500),
      ]);

  Widget buildDates() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (task.dueDate != null) DateStringWidget(task.dueDate, titleString: loc.common_due_date_label),
          DateStringWidget(task.etaDate, titleString: loc.common_eta_date_label),
        ],
      );

  Widget footer(BuildContext context) => Column(children: [
        SizedBox(height: onePadding / 2),
        Row(children: [
          if (isClosed) ...[
            doneIcon(context, true, size: onePadding * 1.4, color: Colors.green),
            SizedBox(width: onePadding / 4),
          ],
          if (hasStatus) status(),
          const Spacer(),
          if (hasSubtasks) closedProgressCount(),
          if (hasLink) ...[
            SizedBox(width: onePadding / 2),
            linkIcon(context, color: darkGreyColor),
          ],
        ]),
        SizedBox(height: onePadding / 2),
        if (hasDates) buildDates(),
      ]);

  Widget buildProgressContent(BuildContext context) => Column(children: [
        header(context),
        if (hasDescription) description(),
        if (hasFooter) footer(context),
      ]);

  @override
  Widget build(BuildContext context) {
    return MTCard(
      onTap: detailedScreen ? null : onTapHeader,
      body: SmartableProgressWidget(
        task,
        buildProgressContent(context),
      ),
      elevation: detailedScreen ? 5 : null,
      margin: EdgeInsets.fromLTRB(onePadding * (detailedScreen ? 0.5 : 2), onePadding / 2, onePadding * (detailedScreen ? 0.5 : 1), onePadding / 2),
    );
  }
}
