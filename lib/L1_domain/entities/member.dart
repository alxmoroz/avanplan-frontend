// Copyright (c) 2022. Alexandr Moroz

import 'person.dart';

class Member extends Person {
  Member({
    required super.id,
    required super.email,
    required super.fullName,
    required super.roles,
    required super.permissions,
    required this.isActive,
    required this.userId,
    required this.taskId,
  });

  final bool isActive;
  final int? userId;
  final int taskId;
}
