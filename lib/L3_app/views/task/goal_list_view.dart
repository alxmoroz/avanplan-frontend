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
import 'ew_filter_dropdown.dart';
import 'task_listview.dart';
import 'task_view_controller.dart';

class GoalListView extends StatelessWidget {
  static String get routeName => 'goal_list';
  TaskViewController get _controller => taskViewController;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: _controller.isLoading,
        navBar: navBar(
          context,
          leading: Container(),
          title: loc.goal_list_title,
          trailing: MTButton.icon(plusIcon(context), () => _controller.addTask(context), padding: EdgeInsets.only(right: onePadding)),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: _controller.rootTask.tasks.isEmpty
              ? EmptyDataWidget(
                  title: loc.goal_list_empty_title,
                  addTitle: loc.goal_title_new,
                  onAdd: () => _controller.addTask(context),
                )
              : ListView(
                  children: [
                    if (tasksFilterController.hasFilters) ...[
                      SizedBox(height: onePadding),
                      EWFilterDropdown(),
                    ],
                    SizedBox(height: onePadding / 2),
                    TaskListView(tasksFilterController.filteredTasks),
                    SizedBox(height: onePadding),
                  ],
                ),
        ),
      ),
    );
  }
}
