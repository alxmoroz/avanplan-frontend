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
  MainController get _controller => mainController;
  Goal? get _goal => _controller.selectedGoal;

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
              title: H2(_goal?.title ?? ''),
              trailing: editIcon(context),
              onTap: () => _controller.editGoal(context),
              dense: true,
              visualDensity: VisualDensity.compact,
            ),
            buildDescription(),
            if (_goal != null)
              GoalCard(
                goal: _goal!,
                onTap: () => taskViewController.showTask(context, null),
              ),
          ],
        ),
      ),
    );
  }
}
