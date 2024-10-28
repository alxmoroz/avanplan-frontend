// Copyright (c) 2023. Alexandr Moroz

import '../entities/task.dart';
import '../entities/task_relation.dart';

extension TaskRelatedTasksExtension on Task {
  bool isRelated(int taskId) => relations.any((r) => r.contains(taskId));
}

extension TaskRelationExtension on TaskRelation {
  int relatedTaskId(int fromTaskId) => fromTaskId == srcId ? dstId : srcId;
  bool contains(int taskId) => taskId == srcId || taskId == dstId;
}
