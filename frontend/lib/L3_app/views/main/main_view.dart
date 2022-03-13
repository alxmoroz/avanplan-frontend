// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../components/buttons.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../extra/services.dart';
import 'drawer.dart';
import 'goal_card.dart';

class MainView extends StatefulWidget {
  static String get routeName => 'main';

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    mainController.initState(context);
    super.initState();
  }

  @override
  void dispose() {
    mainController.dispose();
    super.dispose();
  }

  Widget goalCardBuilder(BuildContext context, int index) {
    return GoalCard(mainController.goals[index]);
  }

  @override
  Widget build(BuildContext context) {
    //TODO: возможно, будет лучше Cupertino для навигации и вообще, более однородно будет смотреться
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: cardBackgroundColor.resolve(context),
        elevation: 7,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext innerCtx) => Button.icon(menuIcon(context), () => Scaffold.of(innerCtx).openDrawer()),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Button.icon(plusIcon(context), mainController.goToGoalView),
          ],
        ),
      ),
      drawer: MTDrawer(),
      body: Container(
        color: backgroundColor.resolve(context),
        child: Column(
          children: [
            SizedBox(height: onePadding),
            Expanded(
              child: ListView.builder(
                itemBuilder: goalCardBuilder,
                itemCount: mainController.goals.length,
              ),
            ),
            SizedBox(height: onePadding),
          ],
        ),
      ),
    );
  }
}
