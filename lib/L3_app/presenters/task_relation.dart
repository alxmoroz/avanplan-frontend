// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_relation.dart';
import '../extra/services.dart';

extension TaskRelationPresenter on TaskRelation {
  int _oppTaskId(int fromTaskId) => fromTaskId == srcId ? dstId : srcId;
  Task? oppositeTask(int fromTaskId) => tasksMainController.task(wsId, _oppTaskId(fromTaskId));

  String title(int fromTaskId) => oppositeTask(fromTaskId)?.title ?? '${loc.task_title} #${_oppTaskId(fromTaskId)}';
}
