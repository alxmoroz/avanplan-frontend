// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/goals/smartable.dart';
import '../../../L1_domain/entities/goals/task.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/date_string_widget.dart';
import '../../components/icons.dart';
import '../../components/mt_card.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'smartable_progress_widget.dart';

class SmartableCard extends StatelessWidget {
  const SmartableCard({required this.element, this.onTap});

  final Smartable element;
  final VoidCallback? onTap;

  bool get isTask => element is Task;
  bool get hasDescription => element.description.isNotEmpty;
  bool get hasDates => element.dueDate != null || element.etaDate != null;
  bool get hasSubtasks => element.tasksCount > 0;
  bool get isClosed => element.closed;

  Widget title(BuildContext context) => NormalText(
        element.title,
        color: darkGreyColor,
        maxLines: 2,
        decoration: isClosed ? TextDecoration.lineThrough : null,
      );

  Widget header(BuildContext context) => Row(children: [
        Expanded(child: title(context)),
        SizedBox(width: onePadding / 2),
        chevronIcon(context),
      ]);

  Widget description() => LayoutBuilder(builder: (context, size) {
        const maxLines = 3;
        final divider = SizedBox(height: onePadding / 4);
        return Column(children: [
          divider,
          Row(children: [
            Expanded(child: SmallText(element.description, maxLines: maxLines, weight: FontWeight.w300)),
          ]),
        ]);
      });

  Widget closedProgressCount() => Row(children: [
        const Spacer(),
        SmallText('${loc.common_mark_done_btn_title} ', weight: FontWeight.w300),
        SmallText('${element.closedTasksCount} / ${element.tasksCount}', weight: FontWeight.w500),
      ]);

  Widget buildDates() => Row(children: [
        if (element.dueDate != null) DateStringWidget(element.dueDate, titleString: loc.common_due_date_label),
        const Spacer(),
        if (element.lefTasksCount > 0) DateStringWidget(element.etaDate, titleString: loc.common_eta_date_label),
      ]);

  @override
  Widget build(BuildContext context) => MTCard(
        onTap: onTap,
        body: SmartableProgressWidget(
          element,
          body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            header(context),
            if (hasDescription) description(),
            if (hasSubtasks && !isClosed) ...[
              SizedBox(height: onePadding / 2),
              closedProgressCount(),
            ],
            if (hasDates) ...[
              SizedBox(height: onePadding / 2),
              buildDates(),
            ],
          ]),
        ),
      );
}
