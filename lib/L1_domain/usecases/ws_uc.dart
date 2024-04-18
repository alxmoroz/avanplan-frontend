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
}
