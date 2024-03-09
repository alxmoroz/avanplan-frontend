// Copyright (c) 2024. Alexandr Moroz

import '../entities/member.dart';
import '../entities/task.dart';

abstract class AbstractTaskMemberRoleRepo {
  Future<Iterable<TaskMember>> assignRoles(Task task, int memberId, Iterable<int> rolesIds);
}
