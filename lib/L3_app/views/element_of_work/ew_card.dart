// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/element_of_work.dart';
import '../../components/constants.dart';
import '../../components/date_string_widget.dart';
import '../../components/icons.dart';
import '../../components/mt_card.dart';
import '../../components/mt_progress.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/ew_overview_presenter.dart';
import '../../presenters/number_presenter.dart';
import 'ew_state_indicator.dart';

class EWCard extends StatelessWidget {
  const EWCard({required this.element, this.onTap, this.expanded = false});

  final ElementOfWork element;
  final VoidCallback? onTap;
  final bool expanded;

  bool get isClosed => element.closed;

  bool get showDescription => expanded && element.description.isNotEmpty;
  bool get showSubtasks => expanded && element.tasksCount > 0;
  bool get showDates => expanded && (element.etaDate != null || element.dueDate != null);

  Widget title(BuildContext context) => H4(
        element.title,
        maxLines: 1,
        decoration: isClosed ? TextDecoration.lineThrough : null,
      );

  Widget header(BuildContext context) => Row(children: [
        Expanded(child: title(context)),
        SizedBox(width: onePadding / 2),
        chevronIcon(context),
      ]);

  Widget description() => LightText(element.description, maxLines: 2);

  Widget subtasksInfo() => Row(children: [
        LightText(loc.ew_subtasks_count(element.tasksCount)),
        const Spacer(),
        if (element.doneRatio > 0) ...[
          SmallText('${loc.common_mark_done_btn_title} '),
          NormalText(element.doneRatio.inPercents),
        ]
      ]);

  Widget buildDates() => Row(children: [
        DateStringWidget(element.dueDate, titleString: loc.ew_due_date_label),
        const Spacer(),
        if (element.leftEWCount > 0) DateStringWidget(element.etaDate, titleString: loc.ew_eta_date_label),
      ]);

  @override
  Widget build(BuildContext context) => MTCard(
        onTap: onTap,
        body: MTProgress(
          ratio: element.doneRatio,
          color: stateColor(element.overallState),
          body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            header(context),
            if (showDescription) ...[
              SizedBox(height: onePadding / 4),
              description(),
            ],
            if (showSubtasks) ...[
              SizedBox(height: onePadding / 2),
              subtasksInfo(),
            ],
            if (showDates) ...[
              SizedBox(height: onePadding / 2),
              buildDates(),
            ],
            SizedBox(height: onePadding / 2),
            EWStateIndicator(element, inCard: true),
          ]),
        ),
      );
}
