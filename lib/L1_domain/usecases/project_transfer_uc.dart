// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';
import '../repositories/abs_project_transfer_repo.dart';

class ProjectTransferUC {
  ProjectTransferUC(this.repo);

  final AbstractProjectTransferRepo repo;

  Future<Iterable<TaskBase>> getProjectTemplates(int wsId) async => await repo.getProjectTemplates(wsId);
  Future<TasksChanges?> transfer(int srcWsId, int dstWsId, int projectId) async => await repo.transfer(srcWsId, dstWsId, projectId);
}
