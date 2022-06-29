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
  const EWCard({required this.ew, this.onTap, this.expanded = false});

  final ElementOfWork ew;
  final VoidCallback? onTap;
  final bool expanded;

  bool get isClosed => ew.closed;

  bool get showDescription => expanded && ew.description.isNotEmpty;
  bool get showSubEW => expanded && ew.ewCount > 0;
  bool get showDates => expanded && (ew.etaDate != null || ew.dueDate != null);

  Widget title(BuildContext context) => H4(
        ew.title,
        maxLines: 1,
        decoration: isClosed ? TextDecoration.lineThrough : null,
      );

  Widget header(BuildContext context) => Row(children: [
        Expanded(child: title(context)),
        SizedBox(width: onePadding / 2),
        chevronIcon(context),
      ]);

  Widget description() => LightText(ew.description, maxLines: 2);

  Widget subEWInfo() => Row(children: [
        LightText(loc.ew_subtasks_count(ew.ewCount)),
        const Spacer(),
        if (ew.doneRatio > 0) ...[
          SmallText('${loc.common_mark_done_btn_title} '),
          NormalText(ew.doneRatio.inPercents),
        ]
      ]);

  Widget buildDates() => Row(children: [
        DateStringWidget(ew.dueDate, titleString: loc.ew_due_date_label),
        const Spacer(),
        if (ew.leftEWCount > 0) DateStringWidget(ew.etaDate, titleString: loc.ew_eta_date_label),
      ]);

  @override
  Widget build(BuildContext context) => MTCard(
        onTap: onTap,
        body: MTProgress(
          ratio: ew.doneRatio,
          color: stateColor(ew.overallState),
          body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            header(context),
            if (showDescription) ...[
              SizedBox(height: onePadding / 4),
              description(),
            ],
            if (showSubEW) ...[
              SizedBox(height: onePadding / 2),
              subEWInfo(),
            ],
            if (showDates) ...[
              SizedBox(height: onePadding / 2),
              buildDates(),
            ],
            SizedBox(height: onePadding / 2),
            EWStateIndicator(ew, inCard: true),
          ]),
        ),
      );
}
