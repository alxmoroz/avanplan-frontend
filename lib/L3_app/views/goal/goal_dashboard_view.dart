// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_card.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../smartable/smartable_header.dart';
import '../smartable/smartable_progress.dart';
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

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _goal != null
          ? MTPage(
              isLoading: _controller.isLoading,
              navBar: navBar(
                context,
                title: loc.goal_title,
                trailing: MTButton.icon(editIcon(context), () => _controller.editGoal(context, _goal), padding: EdgeInsets.only(right: onePadding)),
              ),
              body: SafeArea(
                top: false,
                bottom: false,
                child: ListView(children: [
                  SmartableHeader(element: _goal!),
                  if (hasSubtasks) ...[
                    H4(loc.smartable_dashboard_total_title(_goal!.tasksCount), padding: EdgeInsets.symmetric(horizontal: onePadding)),
                    MTCard(
                      body: SmartableProgress(
                        _goal!,
                        body: Row(children: [
                          Expanded(child: LightText(loc.common_mark_done_btn_title)),
                          H2('${_goal!.closedTasksCount}'),
                          SizedBox(width: onePadding / 2),
                          chevronIcon(context),
                        ]),
                        padding: EdgeInsets.fromLTRB(onePadding, onePadding, onePadding / 2, onePadding),
                      ),
                      onTap: () => taskViewController.showTask(context, null),
                    ),
                  ],
                ]),
              ),
            )
          : Container(),
    );
  }
}
