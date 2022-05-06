// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/cupertino_page.dart';
import '../../components/empty_widget.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../goal/goal_controller.dart';

class MainDashboardView extends StatefulWidget {
  static String get routeName => 'main_dashboard';

  @override
  _MainDashboardViewState createState() => _MainDashboardViewState();
}

class _MainDashboardViewState extends State<MainDashboardView> {
  GoalController get _controller => goalController;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTCupertinoPage(
        body: SafeArea(
          child: Center(
            child: _controller.goals.isEmpty
                ? EmptyDataWidget(
                    title: loc.goal_list_empty_title,
                    addTitle: loc.goal_title_new,
                    onAdd: () => _controller.addGoal(context),
                  )
                : const H1('Status & Text'),
          ),
        ),
      ),
    );
  }
}
