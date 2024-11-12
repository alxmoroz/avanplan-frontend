// Copyright (c) 2023. Alexandr Moroz

import '../entities/task.dart';
import '../utils/dates.dart';
import 'task_dates.dart';

extension TaskStateExtension on Task {
  bool get hasOverdue => hasDueDate && dueDate!.isBefore(today);
  bool get hasRisk => state == TaskState.RISK;
  bool get isFuture => state == TaskState.FUTURE_START;
  bool get isOk => state == TaskState.OK;
  bool get isAhead => state == TaskState.AHEAD;

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
                  : TaskState.FUTURE_DATE;
    }

    return st;
  }
}
