// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/constants.dart';
import '../../components/empty_data_widget.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import '../smartable/smartable_list.dart';
import 'goal_controller.dart';

class GoalListView extends StatelessWidget {
  static String get routeName => 'goal_list';
  GoalController get _controller => goalController;

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
              : ListView(
                  children: [
                    SizedBox(height: onePadding),
                    SmartableList(_controller.goals),
                    SizedBox(height: onePadding),
                  ],
                ),
        ),
      ),
    );
  }
}
