// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_local_settings.dart';
import '../../../../L1_domain/entities_extensions/task_position.dart';
import '../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../presenters/task_tree.dart';
import '../controllers/task_controller.dart';
import '../usecases/state.dart';

extension TreeUC on TaskController {
  List<Task> _filteredSubtasksTree(Task t, Iterable<TaskViewFilter> filters) {
    final taskTree = <Task>[];
    for (Task st in t.subtasks) {
      if (st.isTask) {
        bool pass = false;
        for (TaskViewFilter f in filters) {
          if (f.isAssignee) {
            pass = f.values.contains(st.assigneeId);
          }
        }
        if (pass) {
          taskTree.add(st);
        }
      } else if (st.isGroup) {
        taskTree.addAll(_filteredSubtasksTree(st, filters));
      }
    }
    return taskTree;
  }

  Iterable<Task> get filteredSubtasks => settingsController.hasFilters ? _filteredSubtasksTree(task, settingsController.filters!) : task.subtasks;

  List<Task> subtasksForStatus(int statusId) =>
      filteredSubtasks.where((t) => t.projectStatusId == statusId).sorted((t1, t2) => t1.compareByPosition(t2));

  List<MapEntry<TaskState, List<Task>>> get filteredSubtaskGroups => groups(filteredSubtasks);
}
