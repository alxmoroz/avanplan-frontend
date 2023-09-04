// Copyright (c) 2022. Alexandr Moroz

import '../entities/member.dart';
import '../entities/task.dart';

abstract class AbstractTaskMemberRoleRepo {
  Future<Iterable<Member>> assignRoles(Task task, int memberId, Iterable<int> rolesIds);
}
