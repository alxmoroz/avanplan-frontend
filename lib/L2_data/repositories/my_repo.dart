// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/repositories/abs_api_my_repo.dart';
import '../mappers/user.dart';
import '../mappers/workspace.dart';
import '../mappers/ws_role.dart';
import 'api.dart';

class MyRepo extends AbstractApiMyRepo {
  MyApi get api => openAPI.getMyApi();

  @override
  Future<User?> getMyAccount() async {
    User? user;
    final response = await api.getMyAccountV1MyAccountGet();
    if (response.statusCode == 200) {
      user = response.data?.user;
    }
    return user;
  }

  @override
  Future deleteMyAccount() async => await api.deleteMyAccountV1MyAccountDelete();

  @override
  Future<Iterable<Workspace>> getMyWorkspaces() async {
    final response = await api.getMyWorkspacesV1MyWorkspacesGet();

    final Map<int, Workspace> workspacesMap = {};
    if (response.statusCode == 200) {
      // берем запись, смотрим id её РП. Если такая уже есть у нас, то берём её и в её список ролей добавляем роль из записи.
      // если нет, то создаём и добавляем роль туда
      for (WSUserRoleGet wsUserRoleGet in response.data ?? []) {
        final wsId = wsUserRoleGet.workspace.id;
        final role = wsUserRoleGet.wsRole.wsRole;
        if (workspacesMap[wsId] == null) {
          workspacesMap[wsId] = wsUserRoleGet.workspace.workspace;
        }
        workspacesMap[wsId]!.roles.add(role);
      }
    }
    return workspacesMap.values;
  }
}
