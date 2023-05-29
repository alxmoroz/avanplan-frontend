// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

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
  Task get task => controller.task;

  Widget _groupedItemBuilder(BuildContext context, int index) {
    final group = task.subtaskGroups[index];
    return Column(children: [
      if (controller.showGroupTitles)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P),
          child: GroupStateTitle(task, group.key, place: StateTitlePlace.groupHeader),
        ),
      for (final t in group.value) TaskCard(mainController.taskForId(t.wsId, t.id)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return ListView.builder(
      padding: padding.add(EdgeInsets.only(bottom: padding.bottom > 0 ? 0 : P, top: P_2)),
      itemBuilder: _groupedItemBuilder,
      itemCount: task.subtaskGroups.length,
    );
  }
}
