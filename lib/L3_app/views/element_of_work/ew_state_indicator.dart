// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/element_of_work.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/text_widgets.dart';
import '../../presenters/ew_overview_presenter.dart';

class EWStateIndicator extends StatelessWidget {
  const EWStateIndicator(this.element, {this.inCard = false});

  final ElementOfWork element;
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
