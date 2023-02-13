// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/role.dart';
import '../../L1_domain/repositories/abs_ws_repo.dart';
import '../mappers/role.dart';
import '../services/api.dart';

class RoleRepo extends AbstractWSRepo<Role> {
  RolesApi get api => openAPI.getRolesApi();

  @override
  Future<Iterable<Role>> getAll(int wsId) async {
    final response = await api.rolesV1RolesGet(wsId: wsId);
    return response.data?.map((r) => r.role(wsId)).toList() ?? [];
  }

  @override
  Future<Role?> save(Role data) => throw UnimplementedError();

  @override
  Future<bool> delete(Role data) => throw UnimplementedError();
}
