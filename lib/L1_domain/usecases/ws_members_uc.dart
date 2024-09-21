// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';
import '../repositories/abs_ws_members_repo.dart';

class WSMembersUC {
  WSMembersUC(this.repo);

  final AbstractWSMembersRepo repo;

  Future<Iterable<Task>> memberAssignedTasks(int wsId, int memberId) async => await repo.memberAssignedTasks(wsId, memberId);
}
