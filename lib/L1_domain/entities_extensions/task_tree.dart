// Copyright (c) 2023. Alexandr Moroz

import '../entities/task.dart';

extension TaskTreeExt on Task {
  bool get isProject => type == TType.PROJECT || parentId == null;
  bool get isGoal => type == TType.GOAL;
  bool get isTaskGroup => type == TType.GROUP;
  bool get isBacklog => type == TType.BACKLOG;
  bool get isTask => type == TType.TASK;
  bool get isOpenedGroup => !isTask && !closed;
}
