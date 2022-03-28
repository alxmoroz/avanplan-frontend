// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/card.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/date_string_widget.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({required this.goal, this.alone = false, this.onTap});

  final Goal goal;
  final bool alone;
  final VoidCallback? onTap;

  Widget buildCardTitle() {
    return H3(alone ? goal.title : loc.tasks_title, color: darkGreyColor, maxLines: 1);
  }

  Widget buildTasksCount() {
    final tasksString = '${goal.closedTasksCount} / ${goal.tasksCount}';
    return H1(tasksString);
  }

  Widget buildDates() {
    return alone
        ? Container()
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DateStringWidget(goal.dueDate, titleString: loc.common_due_date_label),
              SizedBox(height: onePadding),
              DateStringWidget(goal.etaDate, titleString: loc.common_eta_date_label),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return MTCard(
      onTap: onTap,
      body: Container(
        color: darkBackgroundColor.resolve(context),
        height: 112,
        child: Stack(
          children: [
            Container(
              color: (goal.dueDate != null ? (goal.pace >= 0 ? goodPaceColor : warningPaceColor) : borderColor).resolve(context),
              width: (goal.closedRatio ?? 0) * _width,
            ),
            Padding(
              padding: EdgeInsets.all(onePadding),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildCardTitle(),
                        if (goal.tasksCount > 0) buildTasksCount(),
                      ],
                    ),
                  ),
                  buildDates(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
