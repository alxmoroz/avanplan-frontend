// Copyright (c) 2022. Alexandr Moroz

import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/member.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/repositories/abs_member_role_repo.dart';
import '../../L2_data/mappers/member.dart';
import '../services/api.dart';

class TaskMemberRoleRepo extends AbstractTaskMemberRoleRepo {
  o_api.TasksRolesApi get api => openAPI.getTasksRolesApi();

  @override
  Future<Iterable<Member>> assignRoles(Task task, int memberId, Iterable<int> rolesIds) async {
    final taskId = task.id!;
    final response = await api.assignRole(
      taskId: taskId,
      memberId: memberId,
      wsId: task.wsId,
      requestBody: BuiltList.from(rolesIds),
    );
    return response.data?.map((m) => m.member(taskId)) ?? [];
  }
}
