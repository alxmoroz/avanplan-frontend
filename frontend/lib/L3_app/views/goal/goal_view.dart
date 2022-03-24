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
import '../main/main_controller.dart';
import 'goal_card.dart';

class GoalView extends StatefulWidget {
  static String get routeName => 'goal';

  @override
  _GoalViewState createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  MainController get controller => mainController;
  Goal? get goal => controller.selectedGoal;

  //TODO: цели обычно всего в двух состояниях. Есть ли смысл отображать название статуса
  Widget buildTitle() {
    return ListTile(
      title: goal?.status != null ? SmallText(goal?.status?.title ?? '-') : null,
      subtitle: H2(goal?.title ?? ''),
      trailing: editIcon(context),
      onTap: () => controller.editGoal(context),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }

  //TODO: дубль кода. Возможно, сам ListTile можно добавить в один файл с showDetailsDialog
  Widget buildDescription() {
    final description = goal?.description ?? '';
    if (description.isNotEmpty) {
      const truncateLength = 100;
      final needTruncate = description.length > truncateLength;

      return ListTile(
        title: LightText(description.substring(0, min(description.length, truncateLength))),
        subtitle: needTruncate ? const MediumText('...', color: mainColor) : null,
        onTap: needTruncate ? () => showDetailsDialog(context, description) : null,
        dense: true,
        visualDensity: VisualDensity.compact,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTCupertinoPage(
        navBar: navBar(context, title: goal != null ? loc.goal_title : loc.goal_title_new),
        body: Column(
          children: [
            SizedBox(height: onePadding),
            buildTitle(),
            buildDescription(),
            if (goal != null)
              GoalCard(
                goal: goal!,
                onTap: () => taskViewController.showTask(context, null),
              ),
          ],
        ),
      ),
    );
  }
}
