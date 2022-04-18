// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/goals/task.dart';
import '../../components/buttons.dart';
import '../../components/card.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/details_dialog.dart';
import '../../components/divider.dart';
import '../../components/icons.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/string_presenter.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({required this.task, this.onTapHeader, this.detailedScreen = false, this.onTapFooter});

  final Task task;
  final bool detailedScreen;
  final VoidCallback? onTapHeader;
  final VoidCallback? onTapFooter;

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
      isSeparateFooter ? onTapHeader : null,
      child: Padding(
        padding: EdgeInsets.fromLTRB(onePadding, onePadding, onePadding, 0),
        child: Row(
          children: [
            Expanded(child: title(context)),
            headerTrailing(context),
          ],
        ),
      ),
    );
  }

  int get cutLength => detailedScreen ? 120 : 50;
  bool get needCut => task.description.length > cutLength;
  bool get isSeparateFooter => detailedScreen && needCut;

  Widget footerTrailing(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: onePadding / 2),
        infoIcon(context),
      ],
    );
  }

  Widget description(BuildContext context) {
    final text = '${task.description.cut(cutLength)}${needCut ? '...' : ''}';
    return detailedScreen ? LightText(text) : SmallText(text);
  }

  Widget status(BuildContext context) => Row(
        children: [
          if (task.closed) ...[
            doneIcon(context, true, size: onePadding * 1.4, color: Colors.green),
            SizedBox(width: onePadding / 4),
          ],
          if (task.status != null) SmallText(task.status?.title ?? ''),
        ],
      );

  Widget closedProgressCount() => task.tasksCount > 0
      ? SmallText(
          '${loc.btn_mark_done_title} ${task.closedTasksCount} / ${task.tasksCount}',
        )
      : Container();

  Widget footer(BuildContext context) {
    return Button(
      '',
      isSeparateFooter ? () => showDetailsDialog(context, task.description) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (task.description.isNotEmpty) ...[
            if (isSeparateFooter) const MTDivider(color: darkGreyColor),
            Padding(
              padding: EdgeInsets.fromLTRB(onePadding, 0, onePadding, 0),
              child: Row(
                children: [
                  Expanded(
                    child: description(context),
                  ),
                  if (isSeparateFooter) footerTrailing(context),
                ],
              ),
            ),
          ],
          const MTDivider(color: darkGreyColor),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: onePadding),
            child: Row(
              children: [
                status(context),
                const Spacer(),
                closedProgressCount(),
                if (task.trackerId != null) ...[
                  SizedBox(width: onePadding),
                  linkIcon(context, color: darkGreyColor),
                ]
              ],
            ),
          ),
          SizedBox(height: onePadding),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MTCard(
      onTap: isSeparateFooter ? null : onTapHeader,
      body: Container(
        child: Stack(
          children: [
            progress(context),
            Column(
              children: [
                header(context),
                footer(context),
              ],
            )
          ],
        ),
      ),
    );
  }
}
