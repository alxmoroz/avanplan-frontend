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
import '../smartable/smartable_card.dart';
import 'goal_controller.dart';

class GoalListView extends StatefulWidget {
  static String get routeName => 'goal_list';

  @override
  _GoalListViewState createState() => _GoalListViewState();
}

class _GoalListViewState extends State<GoalListView> {
  GoalController get _controller => goalController;

  Widget goalCardBuilder(BuildContext context, int index) {
    Widget card = SizedBox(height: onePadding);
    if (index > 0 && index < _controller.goals.length + 1) {
      final goal = _controller.goals[index - 1];
      card = SmartableCard(element: goal, onTap: () => _controller.showGoal(context, goal));
    }
    return card;
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
          trailing: MTButton.icon(plusIcon(context), () => _controller.addGoal(context), padding: EdgeInsets.only(right: onePadding)),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: _controller.goals.isEmpty
              ? EmptyDataWidget(
                  title: loc.goal_list_empty_title,
                  addTitle: loc.goal_title_new,
                  onAdd: () => _controller.addGoal(context),
                )
              : ListView.builder(
                  itemBuilder: goalCardBuilder,
                  itemCount: _controller.goals.length + 2,
                ),
        ),
      ),
    );
  }
}
