// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';

extension TaskTreeExt on Task {
  bool get isProject => type == TType.PROJECT;
  bool get isInbox => type == TType.INBOX;
  bool get isGoal => type == TType.GOAL;
  bool get isGroup => isProject || isGoal;
  bool get isBacklog => type == TType.BACKLOG;
  bool get isTask => type == TType.TASK;
  bool get isCheckItem => type == TType.CHECKLIST_ITEM;
}
