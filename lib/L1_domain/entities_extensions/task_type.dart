// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';
import 'task_params.dart';
import 'task_source.dart';

extension TDTypeExt on TaskDescriptor {
  bool get isProject => type == TType.PROJECT;
  bool get isInbox => type == TType.INBOX;
  bool get isGoal => type == TType.GOAL;
  bool get isProjectOrGoal => isProject || isGoal;
  bool get isBacklog => type == TType.BACKLOG;
  bool get isGroup => isProjectOrGoal || isBacklog;
  bool get isGoalOrBacklog => isGoal || isBacklog;
  bool get isTask => type == TType.TASK;
  bool get isCheckItem => type == TType.CHECKLIST_ITEM;
  bool get isForbidden => type == TType.FORBIDDEN_TASK;
}

extension TaskTypeExt on Task {
  bool get isImportingProject => isProject && taskSource?.isRunning == true;
  bool get isLinked => didImported && taskSource!.keepConnection;
  bool get isLocal => !isLinked;
  bool get isLinkedProject => isProject && isLinked;
}
