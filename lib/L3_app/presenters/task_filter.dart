// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/task.dart';
import 'task_state.dart';
import 'task_tree.dart';

List<MapEntry<TaskState, List<Task>>> groups(Iterable<Task> tasks) {
  final gt = groupBy<Task, TaskState>(tasks, (t) => t.overallState);
  return gt.entries.sortedBy<num>((g) => g.key.index);
}

extension TaskFilterPresenter on Task {
  List<Task> subtasksForStatus(int statusId) => subtasks.where((t) => t.statusId == statusId).toList();
  List<MapEntry<TaskState, List<Task>>> get subtaskGroups => groups(subtasks);
}
