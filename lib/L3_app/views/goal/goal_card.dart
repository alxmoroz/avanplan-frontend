// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/constants.dart';
import '../../components/date_string_widget.dart';
import '../../components/mt_card.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../_base/smartable_progress_widget.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({required this.goal, this.alone = false, this.onTap});

  final Goal goal;
  final bool alone;
  final VoidCallback? onTap;

  Widget buildTitle() => H3(alone ? goal.title : loc.tasks_title, maxLines: 1);

  Widget buildTasksCount() {
    final tasksString = '${goal.closedTasksCount} / ${goal.tasksCount}';
    return H1(tasksString);
  }

  Widget buildDates() => Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        DateStringWidget(goal.dueDate, titleString: loc.common_due_date_label),
        SizedBox(height: onePadding),
        DateStringWidget(goal.etaDate, titleString: loc.common_eta_date_label),
      ]);

  Widget buildProgressBody(BuildContext context) => Row(children: [
        Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            buildTitle(),
            if (goal.tasksCount > 0) buildTasksCount(),
          ]),
        ),
        buildDates(),
      ]);

  @override
  Widget build(BuildContext context) {
    return MTCard(
      onTap: onTap,
      body: SmartableProgressWidget(goal, buildProgressBody(context)),
    );
  }
}
