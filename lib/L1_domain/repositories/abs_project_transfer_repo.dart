// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';

abstract class AbstractProjectTransferRepo {
  Future<Iterable<TaskBase>> getProjectTemplates(int wsId);
  Future<TasksChanges?> transfer(int srcWsId, int dstWsId, int projectId);
}
