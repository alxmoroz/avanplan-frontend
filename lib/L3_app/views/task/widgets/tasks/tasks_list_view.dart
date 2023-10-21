// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/shadowed.dart';
import '../../controllers/task_controller.dart';
import '../header/state_title.dart';
import 'tasks_group.dart';

class TasksListView extends StatelessWidget {
  const TasksListView(this.groups, {this.filters, this.extra});
  final List<MapEntry<TaskState, List<Task>>> groups;
  final Set<TasksFilter>? filters;
  final Widget? extra;

  bool get _isMyTasks => filters?.contains(TasksFilter.my) ?? false;
  bool get _showGroupTitles => groups.length > 1;
  bool get _hasExtra => extra != null;

  Widget _groupedItemBuilder(int groupIndex) {
    if (_hasExtra && groupIndex == groups.length) {
      return extra!;
    } else {
      final group = groups[groupIndex];
      final tasks = group.value;
      final state = group.key;
      final groupBorder = !_showGroupTitles && groupIndex < groups.length - 1;
      return Column(
        children: [
          if (_showGroupTitles || state == TaskState.IMPORTING)
            GroupStateTitle(
              state,
              place: StateTitlePlace.groupHeader,
              topPadding: groupIndex == 0 ? 0 : null,
            ),
          TasksGroup(tasks, isMine: _isMyTasks, bottomDivider: groupBorder, standalone: false),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MTShadowed(
      child: MTAdaptive(
        child: ListView.builder(
          itemBuilder: (_, index) => _groupedItemBuilder(index),
          itemCount: groups.length + (_hasExtra ? 1 : 0),
        ),
      ),
    );
  }
}
