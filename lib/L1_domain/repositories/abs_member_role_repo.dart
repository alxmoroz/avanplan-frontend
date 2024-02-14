// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';
import '../entities/task_member.dart';

abstract class AbstractTaskMemberRoleRepo {
  Future<Iterable<TaskMember>> assignRoles(Task task, int memberId, Iterable<int> rolesIds);
}
