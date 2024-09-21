// Copyright (c) 2024. Alexandr Moroz

import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/ws_member.dart';
import '../../L1_domain/repositories/abs_member_role_repo.dart';
import '../../L2_data/mappers/ws_member.dart';
import '../services/api.dart';

class TaskMembersRolesRepo extends AbstractTaskMembersRolesRepo {
  o_api.TaskMembersRolesApi get api => openAPI.getTaskMembersRolesApi();

  @override
  Future<Iterable<WSMember>> assignMemberRoles(Task task, int memberId, Iterable<int> rolesIds) async {
    final taskId = task.id!;
    final response = await api.assignMemberRoles(
      taskId: taskId,
      memberId: memberId,
      wsId: task.wsId,
      requestBody: BuiltList.from(rolesIds),
    );
    return response.data?.map((m) => m.wsMember(task.wsId)) ?? [];
  }
}
