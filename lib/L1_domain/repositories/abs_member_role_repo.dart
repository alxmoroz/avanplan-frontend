// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';
import '../entities/ws_member.dart';

abstract class AbstractTaskMemberRoleRepo {
  Future<Iterable<WSMember>> assignRoles(Task task, int memberId, Iterable<int> rolesIds) async => throw UnimplementedError();
}
