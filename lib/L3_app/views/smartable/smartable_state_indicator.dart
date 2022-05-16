// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/goals/smartable.dart';
import '../../components/constants.dart';
import '../../components/text_widgets.dart';
import 'smartable_overall_state.dart';

class SmartableStateIndicator extends StatelessWidget {
  const SmartableStateIndicator(this.element);

  final Smartable element;

  @override
  Widget build(BuildContext context) {
    final textDetails = stateTextDetails(element.overallState, overduePeriod: element.overduePeriod, etaRiskPeriod: element.etaRiskPeriod);
    final color = stateColor(element.overallState);

    return Column(children: [
      Row(
        children: [
          stateIcon(context, element.overallState),
          SizedBox(width: onePadding / 4),
          Expanded(child: H3(stateTextTitle(element.overallState), color: color)),
        ],
      ),
      if (textDetails.isNotEmpty) ...[
        SizedBox(height: onePadding / 4),
        Row(children: [Expanded(child: NormalText(textDetails, color: color))])
      ],
    ]);
  }
}
