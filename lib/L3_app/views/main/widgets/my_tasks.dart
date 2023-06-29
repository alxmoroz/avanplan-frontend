// Copyright (c) 2023. Alexandr Moroz

import 'package:avanplan/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/images.dart';
import '../../../components/mt_adaptive.dart';
import '../../../components/mt_button.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_filter_presenter.dart';
import '../../task/task_view.dart';
import '../../task/task_view_controller.dart';
import '../../task/widgets/tasks_group.dart';
import 'dashboard_wrapper.dart';

class MyTasks extends StatelessWidget {
  const MyTasks({this.card = false});
  final bool card;

  Task get _rootTask => mainController.rootTask;
  int get _myTasksCount => mainController.myUpcomingTasksCount;

  Future _goToTasks() async =>
      await Navigator.of(rootKey.currentContext!).pushNamed(TaskView.routeName, arguments: TaskParams(_rootTask.wsId, filters: {TasksFilter.my}));

  Widget _mainInfo(BuildContext context) => _myTasksCount > 0
      ? SizedBox(height: dashboardImageSize(context), child: Center(child: D1('$_myTasksCount', color: mainColor)))
      : MTImage(ImageNames.empty_tasks.toString());

  Widget _contents(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NormalText(loc.my_tasks_title, align: TextAlign.center, color: greyColor),
          const SizedBox(height: P),
          card ? Expanded(child: _mainInfo(context)) : _mainInfo(context),
          H2(_myTasksCount > 0 ? mainController.myUpcomingTasksTitle : loc.task_list_empty_title, align: TextAlign.center, color: darkTextColor),
          const SizedBox(height: P),
          if (!card) ...[
            const SizedBox(height: P),
            Expanded(
              child: _myTasksCount > 0
                  ? TasksGroup(_rootTask.myTasksGroups.first.value, isMine: true)
                  : H3(loc.task_list_empty_hint, align: TextAlign.center),
            ),
            MTButton.main(titleText: loc.my_tasks_all_title, onTap: _goToTasks),
          ],
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => card
          ? DashboardWrapper(
              _contents(context),
              onTap: _goToTasks,
            )
          : _contents(context),
    );
  }
}
