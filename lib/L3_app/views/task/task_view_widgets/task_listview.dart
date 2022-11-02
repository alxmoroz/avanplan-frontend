// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/constants.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_filter_presenter.dart';
import '../task_related_widgets/state_title.dart';
import '../task_related_widgets/task_card.dart';
import '../task_view_controller.dart';

class TaskListView extends StatelessWidget {
  const TaskListView(this.controller);
  final TaskViewController controller;

  Task get task => controller.task;

  Widget _taskItem(int? taskId) => TaskCard(mainController.taskForId(taskId));

  Widget _itemBuilder(BuildContext context, int index) => _taskItem(task.sortedSubtasks[index].id);

  Widget _groupedItemBuilder(BuildContext context, int index) {
    final group = task.subtaskGroups[index];
    return Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: onePadding).copyWith(top: onePadding),
        child: SubtasksStateTitle(task, group.key, style: TaskStateTitleStyle.M),
      ),
      for (final t in group.value) _taskItem(t.id),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Observer(
      builder: (_) => ListView.builder(
        padding: padding.add(EdgeInsets.only(bottom: padding.bottom > 0 ? 0 : onePadding, top: onePadding / 2)),
        itemBuilder: controller.hasGroupedListView ? _groupedItemBuilder : _itemBuilder,
        itemCount: controller.hasGroupedListView ? task.subtaskGroups.length : task.sortedSubtasks.length,
      ),
    );
  }
}
