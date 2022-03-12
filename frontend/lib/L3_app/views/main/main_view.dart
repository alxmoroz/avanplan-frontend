// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/card.dart';
import '../../components/text_widgets.dart';

import '../../components/buttons.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../extra/services.dart';
import 'drawer.dart';

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
    final goal = mainController.goals[index];
    return AMCard(
        title: ListTile(
          title: H3(goal.title, color: darkGreyColor.resolve(context)),
          subtitle: SmallText(goal.description ?? '', maxLines: 1),
        ),
        body: Padding(
          padding: EdgeInsets.all(onePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LightText(goal.report?.closedTasksCount?.toString() ?? ''),
              LightText(goal.report?.tasksCount?.toString() ?? ''),
              LightText(goal.report?.etaDate?.toString() ?? ''),
              LightText(goal.report?.planSpeed?.toString() ?? ''),
              LightText(goal.report?.factSpeed?.toString() ?? ''),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: appBarBgColor.resolve(context),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext innerCtx) => Button.icon(menuIcon(context), () => Scaffold.of(innerCtx).openDrawer()),
        ),
      ),
      drawer: ALDrawer(),
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
