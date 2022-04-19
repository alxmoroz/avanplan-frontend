// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/goals/task.dart';
import '../../components/buttons.dart';
import '../../components/card.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/date_string_widget.dart';
import '../../components/details_dialog.dart';
import '../../components/divider.dart';
import '../../components/icons.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({required this.task, this.onTapHeader, this.detailedScreen = false, this.onTapFooter});

  final Task task;
  final bool detailedScreen;
  final VoidCallback? onTapHeader;
  final VoidCallback? onTapFooter;

  bool get hasLink => task.trackerId != null;

  bool get hasDates => task.dueDate != null || task.etaDate != null;
  bool get hasSubtasks => task.tasksCount > 0;
  bool get hasStatus => task.status != null;
  bool get hasFooter => hasDates || hasSubtasks || hasStatus;

  Widget progress(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Positioned(
      top: 0,
      bottom: 0,
      width: (task.closedRatio ?? 0) * _width,
      child: Container(
        color: (task.dueDate != null ? (task.pace >= 0 ? goodPaceColor : warningPaceColor) : borderColor).resolve(context),
      ),
    );
  }

  Widget title(BuildContext context) => MediumText(
        task.title,
        color: darkGreyColor,
        maxLines: detailedScreen ? 3 : 2,
        sizeScale: detailedScreen ? 1.2 : 1,
        decoration: task.closed ? TextDecoration.lineThrough : null,
      );

  Widget headerTrailing(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: onePadding / 2),
        detailedScreen ? editIcon(context) : chevronIcon(context),
      ],
    );
  }

  Widget header(BuildContext context) {
    return Button(
      '',
      detailedScreen ? onTapHeader : null,
      child: Padding(
        padding: EdgeInsets.fromLTRB(onePadding, onePadding, onePadding, 0),
        child: Row(
          children: [
            if (task.closed) ...[
              doneIcon(context, true, size: onePadding * 1.4, color: Colors.green),
              SizedBox(width: onePadding / 4),
            ],
            Expanded(child: title(context)),
            if (hasLink) ...[
              SizedBox(width: onePadding / 4),
              linkIcon(context, color: darkGreyColor),
            ],
            headerTrailing(context),
          ],
        ),
      ),
    );
  }

  Widget description(BuildContext context) {
    return task.description.isNotEmpty
        ? LayoutBuilder(builder: (context, size) {
            final text = task.description;
            final maxLines = detailedScreen ? 5 : 3;
            final detailedTextWidget = LightText(text, maxLines: maxLines);
            final listTextWidget = SmallText(text, maxLines: maxLines, weight: FontWeight.w300);
            final span = TextSpan(text: text, style: detailedScreen ? detailedTextWidget.style(context) : listTextWidget.style(context));
            final tp = TextPainter(text: span, maxLines: maxLines, textDirection: TextDirection.ltr);
            tp.layout(maxWidth: size.maxWidth);
            final bool separateDescription = tp.didExceedMaxLines && detailedScreen;

            return Button(
              '',
              separateDescription ? () => showDetailsDialog(context, task.description) : null,
              child: Column(
                children: [
                  MTDivider(color: separateDescription ? darkGreyColor : Colors.transparent),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: onePadding),
                    child: Row(
                      children: [
                        Expanded(child: detailedScreen ? detailedTextWidget : listTextWidget),
                        if (separateDescription)
                          Row(
                            children: [
                              SizedBox(width: onePadding / 2),
                              infoIcon(context),
                            ],
                          ),
                      ],
                    ),
                  ),
                  if (hasFooter) MTDivider(color: separateDescription ? darkGreyColor : Colors.transparent),
                ],
              ),
            );
          })
        : Container();
  }

  Widget status() => SmallText(task.status!.title, weight: FontWeight.w500);

  Widget closedProgressCount() => Row(
        children: [
          SmallText('${loc.btn_mark_done_title} ', weight: FontWeight.w300),
          SmallText('${task.closedTasksCount} / ${task.tasksCount}', weight: FontWeight.w500),
        ],
      );

  Widget buildDates() {
    return Padding(
      padding: EdgeInsets.fromLTRB(onePadding, onePadding, onePadding, 0),
      child: Row(
        children: [
          DateStringWidget(task.dueDate, titleString: loc.common_due_date_label),
          const Spacer(),
          DateStringWidget(task.etaDate, titleString: loc.common_eta_date_label),
        ],
      ),
    );
  }

  Widget footer(BuildContext context) => Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: onePadding),
          child: Row(
            children: [
              if (hasStatus) status(),
              const Spacer(),
              if (hasSubtasks) closedProgressCount(),
            ],
          ),
        ),
        if (hasDates) buildDates(),
      ]);

  @override
  Widget build(BuildContext context) {
    return MTCard(
      onTap: detailedScreen ? null : onTapHeader,
      body: Container(
        child: Stack(
          children: [
            progress(context),
            Column(
              children: [
                header(context),
                description(context),
                if (hasFooter) footer(context),
                SizedBox(height: onePadding),
              ],
            )
          ],
        ),
      ),
    );
  }
}
