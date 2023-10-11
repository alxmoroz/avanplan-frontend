// Copyright (c) 2022. Alexandr Moroz

import '../entities/workspace.dart';
import '../repositories/abs_ws_repo.dart';

class WorkspaceUC {
  WorkspaceUC(this.repo);

  final AbstractWSRepo repo;

  Future<Iterable<Workspace>> getAll() async => await repo.getAll();
  Future<Workspace?> getOne(int wsId) async => await repo.getOne(wsId);
  Future<Workspace?> create({WorkspaceUpsert? ws}) async => await repo.create(ws: ws);
  Future<Workspace?> save(WorkspaceUpsert data) async => await repo.save(data);
}
