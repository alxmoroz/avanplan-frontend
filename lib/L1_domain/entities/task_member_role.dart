// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'member.dart';
import 'task_role.dart';

class TaskMemberRole extends WSBounded {
  TaskMemberRole({
    super.id,
    required super.wsId,
    required this.member,
    required this.role,
  });

  final Member member;
  final TaskRole role;
}
