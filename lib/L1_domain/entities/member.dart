// Copyright (c) 2024. Alexandr Moroz

import 'person.dart';

class WSMember extends Person {
  WSMember({
    required super.id,
    required super.email,
    required super.fullName,
    required super.roles,
    required super.permissions,
    required this.isActive,
    required this.userId,
  });

  final bool isActive;
  final int? userId;
}

class TaskMember extends WSMember {
  TaskMember({
    required super.id,
    required super.email,
    required super.fullName,
    required super.roles,
    required super.permissions,
    required super.isActive,
    required super.userId,
    required this.taskId,
  });

  final int taskId;
}
