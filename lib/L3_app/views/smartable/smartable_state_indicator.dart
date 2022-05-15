// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/goals/smartable.dart';
import '../../components/constants.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'smartable_overall_state.dart';

class SmartableStateIndicator extends StatelessWidget {
  const SmartableStateIndicator(this.element);

  final Smartable element;

  @override
  Widget build(BuildContext context) {
    final String stateTextTitle = {
          OverallState.overdue: loc.smart_state_overdue_title,
          OverallState.risk: loc.smart_state_risky_title,
          OverallState.ok: loc.smart_state_ok_title,
        }[element.overallState] ??
        loc.smart_state_no_info_title;

    final String stateTextDetails = {
          OverallState.overdue: '${loc.smart_state_overdue} ${loc.common_days_count(element.overduePeriod!.inDays)}',
          OverallState.risk: loc.smart_state_risky_title,
          OverallState.ok: loc.smart_state_ok_title,
        }[element.overallState] ??
        loc.smart_state_no_info_title;

    return Column(children: [
      Row(
        children: [
          stateIcon(context, element.overallState),
          SizedBox(width: onePadding / 4),
          Expanded(child: H3(stateTextTitle, color: stateColor(element.overallState))),
        ],
      ),
      SizedBox(height: onePadding / 4),
      Row(children: [Expanded(child: NormalText(stateTextDetails, color: stateColor(element.overallState)))])
    ]);
  }
}
