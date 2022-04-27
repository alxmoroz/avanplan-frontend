// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/api_schema/base_upsert.dart';
import '../../L1_domain/entities/auth/workspace.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../../L2_data/mappers/workspace.dart';
import '../../L3_app/extra/services.dart';

class WorkspacesRepo extends AbstractApiRepo<Workspace, BaseUpsert> {
  AuthApi get api => openAPI.getAuthApi();

  @override
  Future<List<Workspace>> getAll() async {
    final response = await api.getMyWorkspacesV1MyWorkspacesGet();

    final List<Workspace> workspaces = [];
    if (response.statusCode == 200) {
      for (WorkspaceSchemaGet ws in response.data?.toList() ?? []) {
        workspaces.add(ws.workspace);
      }
    }
    return workspaces;
  }

  @override
  Future<Workspace?> save(dynamic data) {
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) {
    throw UnimplementedError();
  }
}
