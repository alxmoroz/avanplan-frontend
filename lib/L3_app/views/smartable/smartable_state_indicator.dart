// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/goals/smartable.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/text_widgets.dart';
import 'smartable_overall_state.dart';

class SmartableStateIndicator extends StatelessWidget {
  const SmartableStateIndicator(this.element, {this.inCard = false});

  final Smartable element;
  final bool inCard;

  @override
  Widget build(BuildContext context) {
    final color = inCard ? darkGreyColor : stateColor(element.overallState) ?? darkGreyColor;
    final _stateTextTitle = stateTextTitle(element.overallState);
    final _stateTextDetails = stateTextDetails(element.overallState, overduePeriod: element.overduePeriod, etaRiskPeriod: element.etaRiskPeriod);
    final indicatorText = _stateTextDetails.isNotEmpty ? _stateTextDetails : _stateTextTitle;

    return Row(
      children: [
        stateIcon(context, element.overallState, size: onePadding * (inCard ? 1.5 : 2), color: color),
        SizedBox(width: onePadding / 3),
        Expanded(child: inCard ? SmallText(indicatorText, color: color) : NormalText(indicatorText, color: color)),
      ],
    );
  }
}
