// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_card.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../_base/smartable_card.dart';
import 'goal_controller.dart';

class GoalDashboardView extends StatefulWidget {
  static String get routeName => 'goal_dashboard';

  @override
  _GoalDashboardViewState createState() => _GoalDashboardViewState();
}

class _GoalDashboardViewState extends State<GoalDashboardView> {
  GoalController get _controller => goalController;
  Goal? get _goal => _controller.selectedGoal;

  bool get hasSubtasks => _goal!.tasksCount > 0;
  bool get hasLink => _goal!.trackerId != null;

  Widget closedProgressCount() => Row(children: [
        SmallText('${loc.common_mark_done_btn_title} ', weight: FontWeight.w300),
        SmallText('${_goal?.closedTasksCount} / ${_goal?.tasksCount}', weight: FontWeight.w500),
      ]);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _goal != null
          ? MTPage(
              isLoading: _controller.isLoading,
              navBar: navBar(context, title: _goal != null ? loc.goal_title : loc.goal_title_new),
              body: SafeArea(
                top: false,
                bottom: false,
                child: ListView(children: [
                  if (_goal != null)
                    SmartableCard(
                      element: _goal!,
                      showDetails: true,
                      onTapHeader: () => _controller.editGoal(context, _goal),
                    ),
                  MTCard(
                    body: Padding(
                        padding: EdgeInsets.all(onePadding),
                        child: Row(children: [
                          H3(loc.tasks_title),
                          const Spacer(),
                          if (hasSubtasks) closedProgressCount(),
                          if (hasLink) ...[
                            SizedBox(width: onePadding / 2),
                            linkIcon(context, color: darkGreyColor),
                          ],
                          chevronIcon(context),
                        ])),
                    onTap: () => taskViewController.showTask(context, null),
                  ),
                ]),
              ),
            )
          : Container(),
    );
  }
}
