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

  Widget taskBuilder(BuildContext context, int index) {
    final task = goalController.goal!.tasks.elementAt(index);
    return ListTile(
      title: NormalText(task.title),
    );
  }

  @override
  Widget build(BuildContext context) {
    //TODO: возможно, будет лучше Cupertino
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: cardBackgroundColor.resolve(context),
        elevation: 7,
        title: H3(goalController.goal?.title ?? 'Новая цель'),
      ),
      body: Container(
        color: backgroundColor.resolve(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SizedBox(height: onePadding),
            if (goalController.goal != null) ...[
              // SmallText(goalController.goal?.description ?? ''),
              H3('${goalController.goal?.etaDateStr ?? ''}'),
              Expanded(
                child: ListView.builder(
                  itemBuilder: taskBuilder,
                  itemCount: goalController.goal!.tasks.length,
                ),
              )
            ],
            SizedBox(height: onePadding),
          ],
        ),
      ),
    );
  }
}
