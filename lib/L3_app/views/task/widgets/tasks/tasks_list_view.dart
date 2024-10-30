// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/constants.dart';
import '../analytics/state_title.dart';
import 'card.dart';

class TasksListView extends StatelessWidget {
  const TasksListView(
    this.groups, {
    this.extra,
    this.adaptive = true,
    this.delIconData,
    this.deleteActionLabel,
    this.onTaskTap,
    this.onTaskDelete,
    super.key,
  });
  final List<MapEntry<TaskState, List<Task>>> groups;
  final Widget? extra;
  final bool adaptive;
  final IconData? delIconData;
  final String? deleteActionLabel;
  final Function(Task)? onTaskTap;
  final Function(Task)? onTaskDelete;

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
          _showGroupTitles || state == TaskState.IMPORTING
              ? GroupStateTitle(
                  state,
                  place: StateTitlePlace.groupHeader,
                )
              : const SizedBox(height: P3),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (_, index) {
              final t = tasks[index];
              return TaskCard(
                t,
                key: ObjectKey(t),
                showStateMark: true,
                bottomDivider: index < tasks.length - 1,
                deleteIconData: delIconData,
                deleteActionLabel: deleteActionLabel,
                onTap: onTaskTap,
                onDelete: onTaskDelete,
              );
            },
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: _groupBuilder,
      itemCount: groups.length + (_hasExtra ? 1 : 0),
    );
    return adaptive ? MTAdaptive(child: list) : list;
  }
}
