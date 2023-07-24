// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_level.dart';
import '../../L1_domain/entities_extensions/task_members.dart';
import '../extra/services.dart';
import 'task_comparators.dart';

extension TaskFilterPresenter on Task {
  List<Task> get sortedSubtasks => tasks.sorted(sortByDateAsc);
  List<Task> get sortedLeaves => leaves.sorted(sortByDateAsc);

  List<Task> leavesForStatus(int statusId) => sortedLeaves.where((t) => t.statusId == statusId).toList();

  List<MapEntry<String, List<Task>>> get subtaskGroups {
    final gt = groupBy<Task, String>(sortedSubtasks, (t) => t.overallState);
    return gt.entries.sorted((g1, g2) => g1.key.compareTo(g2.key));
  }

  List<Task> get attentionalTasks => subtaskGroups.isNotEmpty &&
          (isRoot ||
              [
                TaskState.OVERDUE,
                TaskState.RISK,
                TaskState.OK,
              ].contains(subtaskGroups.first.key))
      ? subtaskGroups.first.value
      : [];

  List<Task> get myTasks => openedAssignedLeaves.where((t) => t.assignee!.userId == accountController.user!.id).sorted(sortByDateAsc);
  List<MapEntry<String, List<Task>>> get myTasksGroups {
    final gt = groupBy<Task, String>(myTasks, (t) => t.state);
    return gt.entries.sorted((g1, g2) => g1.key.compareTo(g2.key));
  }
}
