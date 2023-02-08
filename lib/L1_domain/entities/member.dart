// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Member extends Person {
  Member({
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
