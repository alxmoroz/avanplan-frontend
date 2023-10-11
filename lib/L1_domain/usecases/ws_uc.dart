// Copyright (c) 2022. Alexandr Moroz

import '../entities/workspace.dart';
import '../repositories/abs_ws_repo.dart';

class WorkspaceUC {
  WorkspaceUC(this.repo);

  final AbstractWSRepo repo;

  Future<Iterable<Workspace>> getWorkspaces() async => await repo.getWorkspaces();
  Future<Workspace?> createWorkspace({WorkspaceUpsert? ws}) async => await repo.createWorkspace(ws: ws);
  Future<Workspace?> updateWorkspace(WorkspaceUpsert ws) async => await repo.updateWorkspace(ws);
}
