// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../main.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/images.dart';
import '../../../components/mt_adaptive.dart';
import '../../../components/mt_button.dart';
import '../../../components/mt_shadowed.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_filter_presenter.dart';
import '../../task/task_view.dart';
import '../../task/task_view_controller.dart';
import '../../task/widgets/tasks_group.dart';

class MyTasks extends StatelessWidget {
  const MyTasks({this.compact = true});
  final bool compact;

  Task get _rootTask => mainController.rootTask;
  int get _myTasksCount => mainController.myUpcomingTasksCount;

  Future _goToTasks() async =>
      await Navigator.of(rootKey.currentContext!).pushNamed(TaskView.routeName, arguments: TaskParams(_rootTask.ws, filters: {TasksFilter.my}));

  Widget _mainInfo(BuildContext context) => _myTasksCount > 0
      ? SizedBox(height: dashboardImageSize(context), child: Center(child: D1('$_myTasksCount', color: mainColor)))
      : MTImage(ImageNames.empty_tasks.toString());

  Widget _contents(BuildContext context) => MTCardButton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NormalText(loc.my_tasks_title, align: TextAlign.center, color: greyColor),
            const SizedBox(height: P),
            compact ? Expanded(child: _mainInfo(context)) : _mainInfo(context),
            H2(_myTasksCount > 0 ? mainController.myUpcomingTasksTitle : loc.task_list_empty_title, align: TextAlign.center, color: darkTextColor),
            const SizedBox(height: P),
          ],
        ),
        onTap: _goToTasks,
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => compact
          ? _contents(context)
          : Column(
              children: [
                _contents(context),
                const SizedBox(height: P),
                _myTasksCount > 0
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: P_2),
                          child: MTShadowed(child: TasksGroup(_rootTask.myTasksGroups.first.value, isMine: true)),
                        ),
                      )
                    : H3(loc.task_list_empty_hint, align: TextAlign.center),
              ],
            ),
    );
  }
}
