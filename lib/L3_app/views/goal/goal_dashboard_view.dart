// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_details_dialog.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/string_presenter.dart';
import 'goal_card.dart';
import 'goal_controller.dart';

class GoalDashboardView extends StatefulWidget {
  static String get routeName => 'goal_dashboard';

  @override
  _GoalDashboardViewState createState() => _GoalDashboardViewState();
}

class _GoalDashboardViewState extends State<GoalDashboardView> {
  GoalController get _controller => goalController;
  Goal? get _goal => _controller.selectedGoal;

  Widget buildTitle() {
    return ListTile(
      title: H2(_goal?.title ?? ''),
      trailing: editIcon(context),
      onTap: () => _controller.editGoal(context, _goal),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget buildDescription() {
    final description = _goal?.description ?? '';
    if (description.isNotEmpty) {
      const cutLength = 100;
      final needTruncate = description.length > cutLength;

      return ListTile(
        title: LightText(description.cut(cutLength)),
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
      builder: (_) => MTPage(
        isLoading: _controller.isLoading,
        navBar: navBar(context, title: _goal != null ? loc.goal_title : loc.goal_title_new),
        body: SafeArea(
          child: Column(children: [
            SizedBox(height: onePadding),
            buildTitle(),
            buildDescription(),
            if (_goal != null)
              GoalCard(
                goal: _goal!,
                onTap: () => taskViewController.showTask(context, null),
              ),
          ]),
        ),
      ),
    );
  }
}
