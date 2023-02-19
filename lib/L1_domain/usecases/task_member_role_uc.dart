// Copyright (c) 2022. Alexandr Moroz

import '../repositories/abs_member_role_repo.dart';

class TaskMemberRoleUC {
  TaskMemberRoleUC({required this.repo});

  final AbstractTaskMemberRoleRepo repo;

  Future<bool> assignRoles(int wsId, int taskId, int memberId, Iterable<int> rolesIds) async =>
      await repo.assignRoles(wsId, taskId, memberId, rolesIds);
}
