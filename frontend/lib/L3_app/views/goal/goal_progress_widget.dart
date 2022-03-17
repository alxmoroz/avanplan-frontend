// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/card.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';

class GoalProgressWidget extends StatelessWidget {
  const GoalProgressWidget({
    required this.goal,
    this.height,
    this.leading,
    this.middle,
    this.trailing,
    this.onTap,
  });

  final Goal goal;
  final double? height;
  final Widget? leading;
  final Widget? middle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final _height = height ?? 110;
    final _width = MediaQuery.of(context).size.width;

    return MTCard(
      onTap: onTap,
      body: Container(
        color: cardBackgroundColor.resolve(context),
        height: _height,
        child: Stack(
          children: [
            Container(
              color: (goal.pace >= 0 ? goodPaceColor : warningPaceColor).resolve(context),
              width: (goal.closedRatio ?? 0) * _width,
            ),
            Padding(
              padding: EdgeInsets.all(onePadding),
              child: Row(
                children: [
                  if (leading != null) leading!,
                  if (middle != null) Expanded(child: middle!),
                  if (trailing != null) trailing!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
