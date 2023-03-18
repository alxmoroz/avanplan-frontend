// Copyright (c) 2022. Alexandr Moroz

import 'person.dart';

class User extends Person {
  User({
    required super.id,
    required super.email,
    required super.fullName,
    required super.roles,
    required super.permissions,
    required this.wsId,
  });

  final int wsId;
}
