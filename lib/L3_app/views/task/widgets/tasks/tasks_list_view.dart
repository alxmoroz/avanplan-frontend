// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/constants.dart';
import '../analytics/state_title.dart';
import 'card.dart';

class TasksListView extends StatelessWidget {
  const TasksListView(this.groups, {this.extra, super.key});
  final List<MapEntry<TaskState, List<Task>>> groups;
  final Widget? extra;

  bool get _hasExtra => extra != null;
  bool get _showGroupTitles => groups.length > 1;

  Widget _groupBuilder(BuildContext _, int groupIndex) {
    if (_hasExtra && groupIndex == groups.length) {
      return extra!;
    } else {
      final group = groups[groupIndex];
      final tasks = group.value;
      final state = group.key;
      return Column(
        children: [
          if (_showGroupTitles || state == TaskState.IMPORTING)
            GroupStateTitle(
              state,
              place: StateTitlePlace.groupHeader,
            )
          else
            const SizedBox(height: P3),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (_, index) {
              final t = tasks[index];
              return TaskCard(
                t,
                showStateMark: true,
                bottomDivider: index < tasks.length - 1,
              );
            },
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MTAdaptive(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: _groupBuilder,
        itemCount: groups.length + (_hasExtra ? 1 : 0),
      ),
    );
  }
}
