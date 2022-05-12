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
import '../../components/mt_card.dart';
import '../../components/mt_details_dialog.dart';
import '../../components/mt_divider.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../_base/smartable_progress_widget.dart';

class SmartableCard extends StatelessWidget {
  const SmartableCard({
    required this.element,
    this.onTapHeader,
    this.showDetails = false,
    this.breadcrumbs,
  });

  final Smartable element;
  final bool showDetails;
  final String? breadcrumbs;
  final VoidCallback? onTapHeader;

  bool get isTask => element is Task;

  bool get hasDescription => element.description.isNotEmpty;
  bool get hasLink => element.trackerId != null;
  bool get hasDates => element.dueDate != null || element.etaDate != null;
  bool get hasSubtasks => element.tasksCount > 0;
  bool get isClosed => element.closed;
  TaskStatus? get status => isTask ? (element as Task).status : null;
  bool get hasStatus => status != null;

  bool get hasFooter => hasDates || hasSubtasks || hasStatus || hasLink || isClosed;

  Widget title(BuildContext context) => MediumText(
        element.title,
        color: darkGreyColor,
        maxLines: showDetails ? 3 : 2,
        sizeScale: showDetails ? 1.25 : 1,
        decoration: element.closed ? TextDecoration.lineThrough : null,
      );

  Widget header(BuildContext context) {
    return MTButton(
      '',
      showDetails ? onTapHeader : null,
      child: Row(children: [
        Expanded(child: title(context)),
        SizedBox(width: onePadding / 2),
        showDetails ? editIcon(context) : chevronIcon(context),
      ]),
    );
  }

  Widget description() => LayoutBuilder(builder: (context, size) {
        final text = element.description;
        final maxLines = showDetails ? 5 : 3;
        final detailedTextWidget = LightText(text, maxLines: maxLines);
        final listTextWidget = SmallText(text, maxLines: maxLines, weight: FontWeight.w300);
        final span = TextSpan(text: text, style: showDetails ? detailedTextWidget.style(context) : listTextWidget.style(context));
        final tp = TextPainter(text: span, maxLines: maxLines, textDirection: TextDirection.ltr);
        tp.layout(maxWidth: size.maxWidth);
        final bool hasButton = tp.didExceedMaxLines && showDetails;
        final divider = MTDivider(
          color: hasButton ? darkGreyColor : Colors.transparent,
          height: showDetails ? onePadding : onePadding / 4,
        );
        final innerWidget = Column(children: [
          divider,
          Row(children: [
            Expanded(child: showDetails ? detailedTextWidget : listTextWidget),
            if (hasButton) Row(children: [SizedBox(width: onePadding / 2), infoIcon(context)]),
          ]),
          if (hasFooter) divider,
        ]);
        return hasButton ? MTButton('', () => showDetailsDialog(context, element.description), child: innerWidget) : innerWidget;
      });

  Widget closedProgressCount() => Row(children: [
        SmallText('${loc.common_mark_done_btn_title} ', weight: FontWeight.w300),
        SmallText('${element.closedTasksCount} / ${element.tasksCount}', weight: FontWeight.w500),
      ]);

  Widget buildDates() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (element.dueDate != null) DateStringWidget(element.dueDate, titleString: loc.common_due_date_label),
          DateStringWidget(element.etaDate, titleString: loc.common_eta_date_label),
        ],
      );

  Widget footer(BuildContext context) => Column(children: [
        if (isTask || !showDetails) SizedBox(height: onePadding / 2),
        Row(children: [
          if (isClosed && isTask) ...[
            doneIcon(context, true, size: onePadding * 1.4, color: Colors.green),
            SizedBox(width: onePadding / 4),
          ],
          if (hasStatus) SmallText(status!.title, weight: FontWeight.w500),
          if (isTask) const Spacer(),
          if (hasSubtasks && (isTask || !showDetails)) closedProgressCount(),
          if (hasLink && isTask) ...[
            SizedBox(width: onePadding / 2),
            linkIcon(context, color: darkGreyColor),
          ],
        ]),
        if (hasDates) ...[
          SizedBox(height: onePadding / 2),
          buildDates(),
        ]
      ]);

  Widget buildBody(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (breadcrumbs != null && breadcrumbs!.isNotEmpty && showDetails) ...[
          SmallText(breadcrumbs!),
          const MTDivider(color: darkGreyColor),
        ],
        header(context),
        if (hasDescription) description(),
        if (hasFooter) footer(context),
      ]);

  @override
  Widget build(BuildContext context) {
    return MTCard(
        radius: showDetails ? 0 : null,
        onTap: showDetails ? null : onTapHeader,
        body: SmartableProgressWidget(
          element,
          buildBody(context),
        ),
        elevation: showDetails ? 0 : null,
        margin: EdgeInsets.fromLTRB(
          onePadding * (showDetails ? 0 : 1),
          onePadding * (showDetails ? 0 : 0.5),
          onePadding * (showDetails ? 0 : 1),
          onePadding / 2,
        ));
  }
}
