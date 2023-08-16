// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_source.dart';
import 'task_stats.dart';
import 'task_tree.dart';

List<MapEntry<TaskState, List<Task>>> groups(Iterable<Task> tasks) {
  final gt = groupBy<Task, TaskState>(tasks, (t) => t.state);
  return gt.entries.sortedBy<num>((g) => g.key.index);
}

List<Task> attentionalTasks(List<MapEntry<TaskState, List<Task>>> groups) => groups.isNotEmpty &&
        [
          TaskState.OVERDUE,
          TaskState.RISK,
          TaskState.OK,
        ].contains(groups.first.key)
    ? groups.first.value
    : [];

TaskState attentionalState(List<MapEntry<TaskState, List<Task>>> groups) => groups.isNotEmpty ? groups.first.key : TaskState.NO_SUBTASKS;

extension TaskFilterPresenter on Task {
  List<Task> subtasksForStatus(int statusId) => subtasks.where((t) => t.statusId == statusId).toList();
  List<MapEntry<TaskState, List<Task>>> get subtaskGroups => groups(subtasks);
  List<Task> get attentionalSubtasks => attentionalTasks(subtaskGroups);
  TaskState get subtasksState => attentionalState(subtaskGroups);

  Iterable<TaskSource> allTaskSources() {
    final tss = <TaskSource>[];
    for (Task subtask in subtasks) {
      tss.addAll(subtask.allTaskSources());
    }
    if (linked) {
      tss.add(taskSource!);
    }
    return tss;
  }
}
