// Copyright (c) 2024. Alexandr Moroz

import '../entities/member.dart';
import '../entities/task.dart';
import '../repositories/abs_member_role_repo.dart';

class TaskMemberRoleUC {
  TaskMemberRoleUC(this.repo);

  final AbstractTaskMemberRoleRepo repo;

  Future<Iterable<TaskMember>> assignRoles(Task task, int memberId, Iterable<int> rolesIds) async => await repo.assignRoles(task, memberId, rolesIds);
}
