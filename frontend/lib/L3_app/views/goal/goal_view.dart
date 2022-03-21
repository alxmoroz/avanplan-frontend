// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/cupertino_page.dart';
import '../../components/details_dialog.dart';
import '../../components/icons.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../tasks/task_view.dart';
import 'goal_card.dart';
import 'goal_edit_view.dart';

class GoalView extends StatefulWidget {
  static String get routeName => 'goal';

  @override
  _GoalViewState createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  Goal? get _goal => mainController.selectedGoal;

  Future editGoal() async {
    final goal = await showEditGoalDialog(context);
    if (goal != null) {
      mainController.updateGoal(goal);
      if (goal.deleted) {
        Navigator.of(context).pop();
      } else {
        mainController.selectGoal(goal);
      }
    }
  }

  //TODO: дубль кода. Возможно, сам ListTile можно добавить в один файл с showDetailsDialog
  Widget buildDescription() {
    final description = _goal?.description ?? '';
    if (description.isNotEmpty) {
      const truncateLength = 100;
      final needTruncate = description.length > truncateLength;

      return ListTile(
        title: LightText(description.substring(0, min(description.length, truncateLength))),
        subtitle: needTruncate ? const MediumText('...', color: mainColor) : null,
        dense: true,
        visualDensity: VisualDensity.compact,
        onTap: needTruncate ? () => showDetailsDialog(context, description) : null,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTCupertinoPage(
        navBar: navBar(context, title: _goal != null ? loc.goal_title : loc.goal_title_new),
        body: Column(
          children: [
            SizedBox(height: onePadding),
            ListTile(
              title: H2(_goal!.title),
              trailing: editIcon(context),
              onTap: editGoal,
              dense: true,
              visualDensity: VisualDensity.compact,
            ),
            buildDescription(),
            GoalCard(
              goal: _goal!,
              onTap: () => Navigator.of(context).pushNamed(TaskView.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
