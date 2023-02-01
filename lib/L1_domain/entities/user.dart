// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class User extends RPersistable {
  User({
    required super.id,
    required this.email,
    required this.fullName,
  });

  final String? fullName;
  final String email;

  @override
  String toString() => '${fullName ?? email}';
}
