// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_relation.dart';
import '../extra/services.dart';

extension TaskRelationPresenter on TaskRelation {
  int relatedTaskId(int fromTaskId) => fromTaskId == srcId ? dstId : srcId;
  Task? relatedTask(int fromTaskId) => tasksMainController.task(wsId, relatedTaskId(fromTaskId));

  String title(int fromTaskId) => relatedTask(fromTaskId)?.title ?? '${loc.task_title} #${relatedTaskId(fromTaskId)}';
}
