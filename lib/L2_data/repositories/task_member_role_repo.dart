// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/member.dart';
import '../../L1_domain/repositories/abs_api_task_member_role_repo.dart';
import '../../L2_data/mappers/member.dart';
import '../../L2_data/mappers/task_role.dart';
import '../services/api.dart';

class TaskMemberRoleRepo extends AbstractApiTaskMemberRoleRepo {
  o_api.TasksApi get api => openAPI.getTasksApi();

  @override
  Future<Iterable<Member>> getMembers(int wsId, int taskId) async {
    final response = await api.getTaskMemberRolesV1TasksMembersGet(wsId: wsId, taskId: taskId);

    final Map<int, Member> membersMap = {};
    if (response.statusCode == 200) {
      // берем запись, смотрим id её участника. Если такая уже есть у нас, то берём её и в её список ролей добавляем роль из записи.
      // если нет, то создаём и добавляем роль туда
      for (o_api.TaskMemberRoleGet tmr in response.data ?? []) {
        final mId = tmr.member.id;
        final role = tmr.role.role;
        if (membersMap[mId] == null) {
          membersMap[mId] = tmr.member.member(wsId);
        }
        membersMap[mId]!.roles.add(role);
      }
    }
    return membersMap.values;
  }
}
