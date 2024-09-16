// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';
import '../entities/ws_member.dart';
import '../repositories/abs_member_role_repo.dart';

class TaskMemberRoleUC {
  TaskMemberRoleUC(this.repo);

  final AbstractTaskMemberRoleRepo repo;

  Future<Iterable<WSMember>> assignRoles(Task task, int memberId, Iterable<int> rolesIds) async => await repo.assignRoles(task, memberId, rolesIds);
}
