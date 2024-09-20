// Copyright (c) 2024. Alexandr Moroz

import 'person.dart';

class WSMember extends Person {
  WSMember({
    required super.id,
    required this.wsId,
    required super.email,
    required super.fullName,
    required this.roles,
    required this.permissions,
    this.userId,
    super.updatedOn,
  });

  final int wsId;
  final int? userId;
  final Iterable<String> roles;
  final Iterable<String> permissions;
  bool hp(String code) => permissions.contains(code);

  bool isTaskMember = false;
}
