// Copyright (c) 2022. Alexandr Moroz

import '../entities/member.dart';

abstract class AbstractApiTaskMemberRoleRepo {
  Future<Iterable<Member>> getMembers(int wsId, int taskId);
}
