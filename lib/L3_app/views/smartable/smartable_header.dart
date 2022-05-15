// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/goals/smartable.dart';
import '../../../L1_domain/entities/goals/task.dart';
import '../../../L1_domain/entities/goals/task_status.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/date_string_widget.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_details_dialog.dart';
import '../../components/mt_divider.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';

class SmartableHeader extends StatelessWidget {
  const SmartableHeader({
    required this.element,
    this.breadcrumbs,
  });

  final Smartable element;
  final String? breadcrumbs;

  bool get isTask => element is Task;

  bool get hasDescription => element.description.isNotEmpty;
  bool get hasLink => element.trackerId != null;
  bool get hasDates => element.dueDate != null || element.etaDate != null;
  bool get isClosed => element.closed;
  TaskStatus? get status => isTask ? (element as Task).status : null;
  bool get hasStatus => status != null;

  Widget title(BuildContext context) => H2(element.title, decoration: isClosed ? TextDecoration.lineThrough : null);

  Widget header(BuildContext context) {
    return Row(children: [
      Expanded(child: title(context)),
      SizedBox(width: onePadding / 2),
      if (hasLink) ...[
        SizedBox(height: onePadding / 2),
        linkIcon(context, color: darkGreyColor),
      ],
    ]);
  }

  Widget description() => LayoutBuilder(builder: (context, size) {
        final text = element.description;
        const maxLines = 5;
        final detailedTextWidget = LightText(text, maxLines: 5);
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
        return hasButton ? MTButton('', () => showDetailsDialog(context, element.description), child: innerWidget) : innerWidget;
      });

  Widget buildDates() => Row(children: [
        DateStringWidget(element.dueDate, titleString: loc.common_due_date_label),
        const Spacer(),
        if (element.lefTasksCount > 0) DateStringWidget(element.etaDate, titleString: loc.common_eta_date_label),
      ]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(onePadding),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (breadcrumbs != null && breadcrumbs!.isNotEmpty) ...[
          SmallText(breadcrumbs!),
          const MTDivider(),
        ],
        header(context),
        if (hasStatus) ...[
          SizedBox(height: onePadding / 2),
          SmallText(status!.title),
        ],
        if (hasDescription) description(),
        if (hasDates) ...[
          SizedBox(height: onePadding / 2),
          buildDates(),
        ]
      ]),
    );
  }
}
