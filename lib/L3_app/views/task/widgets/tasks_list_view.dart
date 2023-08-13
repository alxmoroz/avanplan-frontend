// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/constants.dart';
import '../../../components/images.dart';
import '../../../components/mt_adaptive.dart';
import '../../../components/mt_shadowed.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../controllers/task_controller.dart';
import 'state_title.dart';
import 'tasks_group.dart';

class TasksListView extends StatelessWidget {
  const TasksListView(this.groups, this.parentType, {this.filters, this.extra});
  final List<MapEntry<TaskState, List<Task>>> groups;
  final String parentType;
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
          if (_showGroupTitles) GroupStateTitle(parentType, state, place: StateTitlePlace.groupHeader),
          TasksGroup(tasks, isMine: _isMyTasks, groupBorder: groupBorder, standalone: false),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MTShadowed(
      child: MTAdaptive(
        child: groups.isNotEmpty || _hasExtra
            ? ListView.builder(
                itemBuilder: (_, index) => _groupedItemBuilder(index),
                itemCount: groups.length + (_hasExtra ? 1 : 0),
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
    );
  }
}
