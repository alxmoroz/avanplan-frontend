// Copyright (c) 2022. Alexandr Moroz

import '../entities/member.dart';
import '../repositories/abs_member_role_repo.dart';

class TaskMemberRoleUC {
  TaskMemberRoleUC(this.repo);

  final AbstractTaskMemberRoleRepo repo;

  Future<Iterable<Member>> assignRoles(int wsId, int taskId, int memberId, Iterable<int> rolesIds) async =>
      await repo.assignRoles(wsId, taskId, memberId, rolesIds);
}
