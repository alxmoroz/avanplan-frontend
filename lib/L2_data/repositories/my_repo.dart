// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/repositories/abs_my_repo.dart';
import '../../L1_domain/system/errors.dart';
import '../../L3_app/extra/services.dart';
import '../mappers/user.dart';
import '../mappers/workspace.dart';

class MyRepo extends AbstractApiMyRepo {
  MyApi get api => openAPI.getMyApi();

  @override
  Future<User?> getMyAccount() async {
    User? user;
    try {
      final response = await api.getMyAccountV1MyAccountGet();
      if (response.statusCode == 200) {
        user = response.data?.user;
      }
    } catch (e) {
      throw MTException(code: 'api_error_get_current_user', detail: e.toString());
    }
    return user;
  }

  @override
  Future<List<Workspace>> getMyWorkspaces() async {
    final response = await api.getMyWorkspacesV1MyWorkspacesGet();

    final List<Workspace> workspaces = [];
    if (response.statusCode == 200) {
      for (WorkspaceGet ws in response.data?.toList() ?? []) {
        workspaces.add(ws.workspace);
      }
    }
    return workspaces;
  }
}
