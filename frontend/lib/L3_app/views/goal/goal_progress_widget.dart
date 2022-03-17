// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';

class GoalProgressWidget extends StatelessWidget {
  const GoalProgressWidget({required this.goal, this.height, this.leading, this.trailing, this.header, this.footer});

  final Goal goal;
  final double? height;
  final Widget? leading;
  final Widget? trailing;
  final Widget? header;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final _height = height ?? 42;
    final _width = MediaQuery.of(context).size.width;

    return Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (header != null) header!,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (leading != null) Expanded(child: leading!),
                    if (trailing != null) trailing!,
                  ],
                ),
                if (footer != null) footer!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
