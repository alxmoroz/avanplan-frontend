// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/goals/smartable.dart';
import '../../components/colors.dart';

class SmartableProgressWidget extends StatelessWidget {
  const SmartableProgressWidget(this.element);

  final Smartable element;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Positioned(
      top: 0,
      bottom: 0,
      width: (element.closedRatio ?? 0) * _width,
      child: Container(
        color: (element.etaDate != null ? (element.hasRisk ? riskyColor : okColor) : borderColor).resolve(context),
      ),
    );
  }
}
