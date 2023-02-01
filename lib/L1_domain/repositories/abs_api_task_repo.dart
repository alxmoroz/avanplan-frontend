// Copyright (c) 2022. Alexandr Moroz

import '../entities/member.dart';
import '../entities/task.dart';
import '../repositories/abs_api_ws_repo.dart';

abstract class AbstractApiTaskRepo extends AbstractApiWSRepo<Task> {
  Future<Iterable<Member>> getMembers(int wsId, int taskId);
}
