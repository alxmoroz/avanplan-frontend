// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/constants.dart';
import '../../controllers/task_controller.dart';
import '../analytics/state_title.dart';
import 'tasks_group.dart';

class TasksListView extends StatelessWidget {
  const TasksListView(this.groups, {this.filters, this.extra, this.scrollable = true});
  final List<MapEntry<TaskState, List<Task>>> groups;
  final Set<TasksFilter>? filters;
  final Widget? extra;
  final bool scrollable;

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
      return Column(
        children: [
          if (groupIndex != 0 || scrollable) const SizedBox(height: P3),
          if (_showGroupTitles || state == TaskState.IMPORTING)
            GroupStateTitle(
              state,
              place: StateTitlePlace.groupHeader,
            ),
          TasksGroup(tasks, isMine: _isMyTasks, standalone: false),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MTAdaptive(
      child: ListView.builder(
        padding: MediaQuery.paddingOf(context).add(const EdgeInsets.only(bottom: P3)),
        shrinkWrap: !scrollable,
        physics: scrollable ? null : const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) => _groupedItemBuilder(index),
        itemCount: groups.length + (_hasExtra ? 1 : 0),
      ),
    );
  }
}
