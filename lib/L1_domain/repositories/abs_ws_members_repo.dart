// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';

abstract class AbstractWSMembersRepo {
  Future<Iterable<Task>> memberAssignedTasks(int wsId, int memberId) async => throw UnimplementedError();
}
