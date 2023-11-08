// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/repositories/abs_ws_repo.dart';
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
  Future<Workspace?> create() async {
    final response = await _api.createWorkspace();
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
}
