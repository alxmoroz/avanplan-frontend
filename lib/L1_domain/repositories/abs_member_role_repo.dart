// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';
import '../entities/ws_member.dart';

abstract class AbstractTaskMembersRolesRepo {
  Future<Iterable<WSMember>> assignMemberRoles(Task task, int memberId, Iterable<int> rolesIds) async => throw UnimplementedError();
}
