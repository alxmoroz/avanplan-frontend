// Copyright (c) 2024. Alexandr Moroz

import 'person.dart';

class WSMember extends Person {
  WSMember({
    required super.id,
    required this.wsId,
    required super.email,
    required super.fullName,
    required super.roles,
    required super.permissions,
    required this.userId,
  });

  final int wsId;
  final int? userId;

  bool isTaskMember = false;
}
