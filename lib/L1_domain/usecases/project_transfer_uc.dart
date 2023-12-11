// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';
import '../repositories/abs_project_transfer_repo.dart';

class ProjectTransferUC {
  ProjectTransferUC(this.repo);

  final AbstractProjectTransferRepo repo;

  Future<Iterable<Project>> getProjectTemplates(int wsId) async => await repo.getProjectTemplates(wsId);
  Future<TasksChanges?> transfer(int srcWsId, int srcProjectId, int dstWsId) async => await repo.transfer(srcWsId, srcProjectId, dstWsId);
}
