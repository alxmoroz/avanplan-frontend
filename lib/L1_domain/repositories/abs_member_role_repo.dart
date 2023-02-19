// Copyright (c) 2022. Alexandr Moroz

abstract class AbstractTaskMemberRoleRepo {
  Future<bool> assignRoles(int wsId, int taskId, int memberId, Iterable<int> rolesIds);
}
