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
import '../../presenters/ew_overview_presenter.dart';
import '../../presenters/number_presenter.dart';
import 'ew_state_indicator.dart';

class EWOverview extends StatelessWidget {
  const EWOverview(this.ew);

  final Task ew;

  bool get hasDescription => ew.description.isNotEmpty;
  bool get hasLink => ew.trackerId != null;
  bool get hasDates => ew.dueDate != null || ew.etaDate != null;
  bool get isClosed => ew.closed;
  bool get hasStatus => ew.status != null;
  bool get hasSubEW => ew.leafTasksCount > 0;

  Widget description() => LayoutBuilder(builder: (context, size) {
        final text = ew.description;
        final maxLines = ew.leafTasksCount > 0 ? 3 : 9;
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
        return hasButton ? MTButton('', () => showDetailsDialog(context, ew.description), child: innerWidget) : innerWidget;
      });

  Widget buildDates() => Row(children: [
        DateStringWidget(ew.dueDate, titleString: loc.ew_due_date_label),
        const Spacer(),
        if (ew.leftTasksCount > 0) DateStringWidget(ew.etaDate, titleString: loc.ew_eta_date_label),
      ]);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(onePadding),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (hasStatus) ...[
          SizedBox(height: onePadding / 2),
          SmallText(ew.status!.title),
        ],
        if (hasDescription) description(),
        if (hasDates) ...[
          SizedBox(height: onePadding / 2),
          buildDates(),
        ],
        SizedBox(height: onePadding),
        EWStateIndicator(ew),
        if (hasSubEW) ...[
          SizedBox(height: onePadding / 2),
          SampleProgress(
            ratio: ew.doneRatio,
            color: stateColor(ew.overallState),
            titleText: loc.ew_subtasks_count(ew.leafTasksCount),
            trailingText: ew.doneRatio > 0 ? ew.doneRatio.inPercents : '',
          ),
        ]
      ]),
    );
  }
}
