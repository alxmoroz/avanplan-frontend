// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_dates.dart';
import '../../../../L1_domain/entities_extensions/task_state.dart';
import '../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../presenters/task_state.dart';
import '../../../presenters/task_view.dart';
import '../controllers/task_controller.dart';
import 'tree.dart';

List<MapEntry<TaskState, List<Task>>> groups(Iterable<Task> tasks) {
  final gt = groupBy<Task, TaskState>(tasks, (t) => TaskController(taskIn: t).overallState);
  return gt.entries.sortedBy<num>((g) => g.key.index);
}

extension StateUC on TaskController {
  TaskState _attentionalState(List<MapEntry<TaskState, List<Task>>> groups) => groups.isNotEmpty ? groups.first.key : TaskState.NO_SUBTASKS;
  List<Task> _attentionalTasks(List<MapEntry<TaskState, List<Task>>> groups) => groups.isNotEmpty &&
          [
            TaskState.OVERDUE,
            TaskState.RISK,
            TaskState.OK,
            TaskState.AHEAD,
          ].contains(groups.first.key)
      ? groups.first.value
      : [];

  List<Task> get _attentionalSubtasks => _attentionalTasks(filteredSubtaskGroups);
  TaskState get _subtasksState => _attentionalState(filteredSubtaskGroups);

  TaskState get overallState {
    final t = task;
    return t.isImportingProject
        ? TaskState.IMPORTING
        : _attentionalSubtasks.isNotEmpty && !t.hasDueDate
            ? _subtasksState
            : t.isBacklog
                ? TaskState.BACKLOG
                : t.isTask
                    ? t.leafState
                    : t.hasGroupAnalytics || t.closed
                        ? t.state
                        : TaskState.NO_ANALYTICS;
  }

  String get overallStateTitle {
    final t = task;
    final attST = _attentionalTasks(filteredSubtaskGroups);
    final attCount = attST.isNotEmpty ? attST.length : 0;
    return t.isTask || (attST.isEmpty || t.hasDueDate) ? t.stateTitle : t.subtasksStateTitle(attCount, _subtasksState);
  }
}
