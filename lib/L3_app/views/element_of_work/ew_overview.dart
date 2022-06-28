// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/element_of_work.dart';
import '../../components/constants.dart';
import '../../components/date_string_widget.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_details_dialog.dart';
import '../../components/mt_divider.dart';
import '../../components/mt_progress.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/ew_overview_presenter.dart';
import '../../presenters/number_presenter.dart';
import 'ew_state_indicator.dart';

class EWOverview extends StatelessWidget {
  const EWOverview(this.element);

  final ElementOfWork element;

  bool get hasDescription => element.description.isNotEmpty;
  bool get hasLink => element.trackerId != null;
  bool get hasDates => element.dueDate != null || element.etaDate != null;
  bool get isClosed => element.closed;
  bool get hasStatus => element.status != null;
  bool get hasSubtasks => element.tasksCount > 0;

  Widget description() => LayoutBuilder(builder: (context, size) {
        final text = element.description;
        final maxLines = element.tasksCount > 0 ? 3 : 9;
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
        return hasButton ? MTButton('', () => showDetailsDialog(context, element.description), child: innerWidget) : innerWidget;
      });

  Widget buildDates() => Row(children: [
        DateStringWidget(element.dueDate, titleString: loc.ew_due_date_label),
        const Spacer(),
        if (element.leftEWCount > 0) DateStringWidget(element.etaDate, titleString: loc.ew_eta_date_label),
      ]);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(onePadding),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (hasStatus) ...[
          SizedBox(height: onePadding / 2),
          SmallText(element.status!.title),
        ],
        if (hasDescription) description(),
        if (hasDates) ...[
          SizedBox(height: onePadding / 2),
          buildDates(),
        ],
        SizedBox(height: onePadding),
        EWStateIndicator(element),
        if (hasSubtasks) ...[
          SizedBox(height: onePadding / 2),
          SampleProgress(
            ratio: element.doneRatio,
            color: stateColor(element.overallState),
            titleText: loc.ew_subtasks_count(element.tasksCount),
            trailingText: element.doneRatio > 0 ? element.doneRatio.inPercents : '',
          ),
        ]
      ]),
    );
  }
}
