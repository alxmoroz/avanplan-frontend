//  Copyright (c) 2023. Alexandr Moroz

import 'base_entity.dart';

abstract class Person extends RPersistable {
  Person({
    super.id,
    super.createdOn,
    super.updatedOn,
    required this.email,
    required this.fullName,
    required this.roles,
    required this.permissions,
  });

  final String? fullName;
  final String email;

  final Iterable<String> roles;
  final Iterable<String> permissions;

  @override
  String toString() => fullName ?? email;

  bool hp(String code) => permissions.contains(code);

  String get initials => (fullName ?? email.substring(0, 2)).split(RegExp(r'\s')).map((word) => word.substring(0, 1).toUpperCase()).join('');
}
