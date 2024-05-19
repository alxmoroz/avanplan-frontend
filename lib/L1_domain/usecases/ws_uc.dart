// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';
import '../entities/workspace.dart';
import '../repositories/abs_ws_repo.dart';

class WorkspaceUC {
  WorkspaceUC(this.repo);

  final AbstractWSRepo repo;

  Future<Iterable<Workspace>> getAll() async => await repo.getAll();
  Future<Workspace?> getOne(int wsId) async => await repo.getOne(wsId);
  Future<Workspace?> save(WorkspaceUpsert data) async => await repo.save(data);

  Future<Iterable<Task>> getProjects(int wsId, {bool? imported, bool? closed}) async => await repo.getProjects(
        wsId,
        imported: imported,
        closed: closed,
      );
  Future<Iterable<Task>> getMyTasks(int wsId, {int? projectId}) async => await repo.getMyTasks(wsId, projectId: projectId);

  Future<Iterable<Project>> getProjectTemplates(int wsId) async => await repo.projectTemplates(wsId);
  Future<TasksChanges?> createFromTemplate(int srcWsId, int srcProjectId, int dstWsId) async =>
      await repo.createFromTemplate(srcWsId, srcProjectId, dstWsId);

  Future<Iterable<Task>> sourcesForMove(int wsId) async => await repo.sourcesForMove(wsId);
  Future<Iterable<Task>> destinationsForMove(int wsId, String taskType) async => await repo.destinationsForMove(wsId, taskType);
}
