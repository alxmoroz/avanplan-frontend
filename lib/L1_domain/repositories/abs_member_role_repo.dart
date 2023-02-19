// Copyright (c) 2022. Alexandr Moroz

import '../entities/member.dart';

abstract class AbstractTaskMemberRoleRepo {
  Future<Iterable<Member>> assignRoles(int wsId, int taskId, int memberId, Iterable<int> rolesIds);
}
