// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';
import '../entities/ws_member_contact.dart';

abstract class AbstractWSMembersRepo {
  Future<Iterable<Task>> memberAssignedTasks(int wsId, int memberId) async => throw UnimplementedError();
  Future<Iterable<WSMemberContact>> projectMemberContacts(int wsId, int taskId, int memberId) async => throw UnimplementedError();
}
