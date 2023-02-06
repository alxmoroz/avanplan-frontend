// Copyright (c) 2022. Alexandr Moroz

import 'role.dart';
import 'user.dart';

class Member extends User {
  Member({
    required super.id,
    required super.email,
    required super.fullName,
    required this.roles,
    required this.isActive,
  });

  List<Role> roles = [];
  bool isActive;

  @override
  String toString() => '${fullName ?? email}';
}
