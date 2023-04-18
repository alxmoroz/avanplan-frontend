// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_level.dart';
import '../../../components/constants.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_filter_presenter.dart';
import '../../../usecases/task_ext_actions.dart';
import '../task_view_controller.dart';
import '../widgets/state_title.dart';
import '../widgets/task_add_button.dart';
import '../widgets/task_add_menu.dart';
import '../widgets/task_card.dart';

class TaskListView extends StatelessWidget {
  const TaskListView(this.controller);
  final TaskViewController controller;

  Task get task => controller.task;

  Widget? get bottomBar => task.canCreate
      ? Row(children: [
          const Spacer(),
          task.isWorkspace ? TaskAddMenu(controller) : TaskAddButton(controller, compact: true),
        ])
      : null;

  Widget _taskItem(int? taskId) => TaskCard(mainController.taskForId(taskId));

  Widget _groupedItemBuilder(BuildContext context, int index) {
    final group = task.subtaskGroups[index];
    return Column(children: [
      if (controller.showGroupTitles)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P),
          child: GroupStateTitle(task, group.key, place: StateTitlePlace.groupHeader),
        ),
      for (final t in group.value) _taskItem(t.id),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Observer(
      builder: (_) => ListView.builder(
        padding: padding.add(EdgeInsets.only(bottom: padding.bottom > 0 ? 0 : P, top: P_2)),
        itemBuilder: _groupedItemBuilder,
        itemCount: task.subtaskGroups.length,
      ),
    );
  }
}
