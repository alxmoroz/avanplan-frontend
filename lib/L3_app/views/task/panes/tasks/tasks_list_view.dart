// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_level.dart';
import '../../../../components/constants.dart';
import '../../../../components/images.dart';
import '../../../../components/mt_adaptive.dart';
import '../../../../components/mt_shadowed.dart';
import '../../../../components/text_widgets.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_filter_presenter.dart';
import '../../task_view_controller.dart';
import '../../widgets/state_title.dart';
import '../../widgets/tasks_group.dart';

class TasksListView extends StatelessWidget {
  const TasksListView(this.controller);
  final TaskViewController controller;

  Task get _task => controller.task;
  List<MapEntry<TaskState, List<Task>>> get _groups => controller.isMyTasks ? _task.myTasksGroups : _task.subtaskGroups;
  bool get _showGroupTitles => _groups.length > 1;

  Widget _groupedItemBuilder(Task parent, List<MapEntry<TaskState, List<Task>>> groups, int groupIndex) {
    final group = groups[groupIndex];
    final tasks = group.value;
    final state = group.key;
    final groupBorder = !_showGroupTitles && groupIndex < groups.length - 1;
    return Column(
      children: [
        if (_showGroupTitles) GroupStateTitle(parent, state, place: StateTitlePlace.groupHeader),
        TasksGroup(tasks, isMine: controller.isMyTasks, groupBorder: groupBorder, standalone: false),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Observer(
      builder: (_) => MTShadowed(
        child: MTAdaptive(
          child: _groups.isNotEmpty
              ? ListView.builder(
                  padding: padding.add(EdgeInsets.only(top: _task.isRoot ? P : 0)),
                  itemBuilder: (_, index) => _groupedItemBuilder(_task, _groups, index),
                  itemCount: _groups.length,
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: P),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        MTImage(ImageNames.empty_tasks.toString()),
                        H3(loc.task_list_empty_title, align: TextAlign.center),
                        const SizedBox(height: P),
                        NormalText(loc.task_list_empty_hint, align: TextAlign.center, height: 1.2),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
