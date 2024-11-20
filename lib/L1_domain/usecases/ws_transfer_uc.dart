// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';
import '../repositories/abs_ws_transfer_repo.dart';

class WSTransferUC {
  WSTransferUC(this.repo);

  final AbstractWSTransferRepo repo;

  Future<Iterable<Project>> getProjectTemplates(int wsId) async => await repo.projectTemplates(wsId);
  Future<TasksChanges?> createFromTemplate(int srcWsId, int srcProjectId, int dstWsId) async =>
      await repo.createFromTemplate(srcWsId, srcProjectId, dstWsId);

  Future<Iterable<Task>> sourcesForMove(int wsId) async => await repo.sourcesForMove(wsId);
  Future<Iterable<Task>> destinationsForMove(int wsId, TType type) async => await repo.destinationsForMove(wsId, type);
}
