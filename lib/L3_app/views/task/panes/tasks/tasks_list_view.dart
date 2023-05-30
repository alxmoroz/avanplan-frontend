// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/constants.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_filter_presenter.dart';
import '../../widgets/state_title.dart';
import '../../widgets/task_card.dart';
import 'tasks_pane_controller.dart';

class TasksListView extends StatelessWidget {
  const TasksListView(this.controller);

  final TasksPaneController controller;

  Widget _groupedItemBuilder(Task parent, List<MapEntry<TaskState, List<Task>>> groups, int groupIndex) {
    final group = groups[groupIndex];
    final tasks = group.value;
    return Column(
      children: [
        if (controller.showGroupTitles)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P, bottom: P_2),
            child: GroupStateTitle(parent, group.key, place: StateTitlePlace.groupHeader),
          ),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          itemBuilder: (BuildContext _, int index) {
            final t = tasks[index];
            return TaskCard(mainController.taskForId(t.wsId, t.id),
                bottomBorder: index < tasks.length - 1 || (!controller.showGroupTitles && groupIndex < groups.length - 1));
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Observer(builder: (_) {
      final parent = mainController.taskForId(controller.task.wsId, controller.task.id);
      final groups = parent.subtaskGroups;
      return ListView.builder(
        shrinkWrap: true,
        padding: padding.add(EdgeInsets.only(bottom: padding.bottom > 0 ? 0 : P, top: P_2)),
        itemBuilder: (_, index) => _groupedItemBuilder(parent, groups, index),
        itemCount: groups.length,
      );
    });
  }
}
