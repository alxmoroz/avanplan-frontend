// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/buttons.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/empty_widget.dart';
import '../../components/icons.dart';
import '../../extra/services.dart';
import '../goal/goal_card.dart';
import 'drawer.dart';

class MainView extends StatefulWidget {
  static String get routeName => 'main';

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  Widget goalCardBuilder(BuildContext context, int index) {
    final goal = mainController.goals[index];
    return GoalCard(goal: goal, alone: true, onTap: () => goalController.showGoal(context, goal));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: доработать в соотв. с использованием параметра LOADING
    return Observer(
      builder: (_) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: darkBackgroundColor.resolve(context),
          elevation: 7,
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (BuildContext innerCtx) => Button.icon(menuIcon(context), () => Scaffold.of(innerCtx).openDrawer()),
          ),
          title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Button.icon(plusIcon(context), () => goalController.addGoal(context)),
          ]),
        ),
        drawer: MTDrawer(),
        body: Container(
          color: backgroundColor.resolve(context),
          child: mainController.goals.isEmpty
              ? Center(
                  child: EmptyDataWidget(
                  title: loc.goal_list_empty_title,
                  addTitle: loc.goal_title_new,
                  onAdd: () => goalController.addGoal(context),
                ))
              : Column(children: [
                  SizedBox(height: onePadding),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: goalCardBuilder,
                      itemCount: mainController.goals.length,
                    ),
                  ),
                  SizedBox(height: onePadding),
                ]),
        ),
      ),
    );
  }
}
