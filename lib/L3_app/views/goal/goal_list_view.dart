// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/constants.dart';
import '../../components/empty_widget.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import 'goal_card.dart';
import 'goal_controller.dart';

class GoalListView extends StatefulWidget {
  static String get routeName => 'goal_list';

  @override
  _GoalListViewState createState() => _GoalListViewState();
}

class _GoalListViewState extends State<GoalListView> {
  GoalController get _controller => goalController;

  Widget goalCardBuilder(BuildContext context, int index) {
    final goal = _controller.goals[index];
    return GoalCard(goal: goal, alone: true, onTap: () => _controller.showGoal(context, goal));
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: _controller.isLoading,
        navBar: navBar(
          context,
          leading: Container(),
          title: loc.goal_list_title,
          trailing: MTButton.icon(plusIcon(context), () => _controller.addGoal(context)),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: _controller.goals.isEmpty
              ? Center(
                  child: EmptyDataWidget(
                  title: loc.goal_list_empty_title,
                  addTitle: loc.goal_title_new,
                  onAdd: () => _controller.addGoal(context),
                ))
              : Column(children: [
                  SizedBox(height: onePadding),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: goalCardBuilder,
                      itemCount: _controller.goals.length,
                    ),
                  ),
                  SizedBox(height: onePadding),
                ]),
        ),
      ),
    );
  }
}
