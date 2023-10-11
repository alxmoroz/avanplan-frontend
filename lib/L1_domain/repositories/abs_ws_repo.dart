// Copyright (c) 2022. Alexandr Moroz

import '../entities/workspace.dart';

abstract class AbstractWSRepo {
  Future<Iterable<Workspace>> getWorkspaces();
  Future<Workspace?> getWorkspace(int wsId);
  Future<Workspace?> createWorkspace({WorkspaceUpsert? ws});
  Future<Workspace?> updateWorkspace(WorkspaceUpsert ws);
}
