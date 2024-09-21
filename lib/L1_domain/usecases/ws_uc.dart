// Copyright (c) 2024. Alexandr Moroz

import '../entities/workspace.dart';
import '../repositories/abs_api_repo.dart';

class WorkspaceUC {
  WorkspaceUC(this.repo);

  final AbstractApiRepo<Workspace, WorkspaceUpsert> repo;

  Future<Iterable<Workspace>> getAll() async => await repo.getAll();
  Future<Workspace?> getOne(int wsId) async => await repo.getOne(wsId);
  Future<Workspace?> save(WorkspaceUpsert data) async => await repo.save(data);
}
