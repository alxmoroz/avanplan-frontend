// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/repositories/abs_ws_repo.dart';
import '../mappers/task.dart';
import '../mappers/workspace.dart';
import '../services/api.dart';

class WSRepo extends AbstractWSRepo {
  o_api.WorkspacesApi get _api => openAPI.getWorkspacesApi();

  @override
  Future<Iterable<Workspace>> getAll() async {
    final response = await _api.getMyWorkspaces();
    return response.data?.map((ws) => ws.workspace) ?? [];
  }

  @override
  Future<Workspace?> getOne(int id) async {
    final response = await _api.getWorkspace(wsId: id);
    return response.data?.workspace;
  }

  @override
  Future<Workspace?> save(WorkspaceUpsert data) async {
    final response = await _api.updateWorkspace(
        wsId: data.id!,
        workspaceUpsert: (o_api.WorkspaceUpsertBuilder()
              ..id = data.id
              ..code = data.code
              ..title = data.title
              ..description = data.description)
            .build());
    return response.data?.workspace;
  }

  @override
  Future<Iterable<Task>> getMyTasks(int wsId, {int? projectId}) async {
    final response = await _api.myTasks(wsId: wsId, projectId: projectId);
    return response.data?.map((t) => t.task(wsId)) ?? [];
  }

  @override
  Future<Iterable<Task>> getProjects(int wsId, {bool? closed, bool? imported}) async {
    final response = await _api.myProjects(wsId: wsId, closed: closed, imported: imported);
    return response.data?.map((t) => t.task(wsId)) ?? [];
  }
}
