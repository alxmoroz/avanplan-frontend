// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/goal_presenter.dart';

class GoalView extends StatefulWidget {
  static String get routeName => 'goal';

  @override
  _GoalViewState createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  @override
  void initState() {
    goalController.initState(context);
    super.initState();
  }

  @override
  void dispose() {
    goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: возможно, будет лучше Cupertino
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cardBackgroundColor.resolve(context),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(onePadding),
        color: backgroundColor.resolve(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: onePadding),
            H1(goalController.goal?.title ?? 'Новая цель'),
            MediumText(goalController.goal?.description ?? ''),
            H3('${goalController.goal?.etaDateStr ?? ''}'),
            SizedBox(height: onePadding),
          ],
        ),
      ),
    );
  }
}
