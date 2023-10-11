// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/repositories/abs_ws_repo.dart';
import '../mappers/workspace.dart';
import '../services/api.dart';

class WSRepo extends AbstractWSRepo {
  o_api.WorkspacesApi get _api => openAPI.getWorkspacesApi();

  @override
  Future<Iterable<Workspace>> getWorkspaces() async {
    final response = await _api.getMyWorkspacesV1WorkspacesGet();
    return response.data?.map((ws) => ws.workspace) ?? [];
  }

  @override
  Future<Workspace?> getWorkspace(int wsId) async {
    final response = await _api.getWorkspaceV1WorkspacesWsIdGet(wsId: wsId);
    return response.data?.workspace;
  }

  @override
  Future<Workspace?> createWorkspace({WorkspaceUpsert? ws}) async {
    o_api.WorkspaceUpsert? wsData;
    if (ws != null) {
      wsData = (o_api.WorkspaceUpsertBuilder()
            ..code = ws.code
            ..title = ws.title
            ..description = ws.description)
          .build();
    }
    final response = await _api.createWorkspaceV1WorkspacesPost(workspaceUpsert: wsData);
    return response.data?.workspace;
  }

  @override
  Future<Workspace?> updateWorkspace(WorkspaceUpsert ws) async {
    final response = await _api.updateWorkspaceV1WorkspacesWsIdPost(
        wsId: ws.id!,
        workspaceUpsert: (o_api.WorkspaceUpsertBuilder()
              ..id = ws.id
              ..code = ws.code
              ..title = ws.title
              ..description = ws.description)
            .build());
    return response.data?.workspace;
  }
}
