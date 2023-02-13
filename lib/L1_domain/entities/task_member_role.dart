// Copyright (c) 2023. Alexandr Moroz

import 'base_entity.dart';

class TaskMemberRole extends WSBounded {
  TaskMemberRole({
    required super.id,
    required super.wsId,
    required this.taskId,
    required this.memberId,
    required this.roleId,
  });

  final int taskId;
  final int memberId;
  final int roleId;
}
