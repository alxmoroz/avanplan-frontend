// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/repositories/abs_ws_members_repo.dart';
import '../mappers/task.dart';
import '../services/api.dart';

class WSMembersRepo extends AbstractWSMembersRepo {
  o_api.WSMembersApi get _api => openAPI.getWSMembersApi();

  // TODO: deprecated?
  @override
  Future<Iterable<Task>> memberAssignedTasks(int wsId, int memberId) async {
    final response = await _api.memberAssignedTasks(wsId: wsId, memberId: memberId);
    return response.data?.map((t) => t.task(wsId)) ?? [];
  }
}
