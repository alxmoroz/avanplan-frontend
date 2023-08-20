// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities/task.dart';
import '../utils/dates.dart';
import 'task_stats.dart';
import 'task_tree.dart';

TaskState stateFromStr(String strState) => TaskState.values.firstWhereOrNull((s) => s.name == strState) ?? TaskState.NO_INFO;

extension TaskStateExtension on Task {
  TaskState get leafState {
    TaskState st = TaskState.NO_DUE;
    if (closed) {
      st = TaskState.CLOSED;
    } else if (hasDueDate) {
      final due = dueDate!.date;
      st = hasOverdue
          ? TaskState.OVERDUE
          : yesterday.isBefore(due) && due.isBefore(tomorrow)
              ? TaskState.TODAY
              : today.isBefore(due) && due.isBefore(nextWeek)
                  ? TaskState.THIS_WEEK
                  : TaskState.FUTURE_DUE;
    }

    return st;
  }

  TaskState get overallState => isTask ? leafState : state;
}
