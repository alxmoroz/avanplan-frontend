// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';
import '../entities/task_member.dart';
import '../repositories/abs_member_role_repo.dart';

class TaskMemberRoleUC {
  TaskMemberRoleUC(this.repo);

  final AbstractTaskMemberRoleRepo repo;

  Future<Iterable<TaskMember>> assignRoles(Task task, int memberId, Iterable<int> rolesIds) async => await repo.assignRoles(task, memberId, rolesIds);
}
