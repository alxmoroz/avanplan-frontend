// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Person extends Emailable {
  Person({
    required super.id,
    required super.email,
    this.firstname,
    this.lastname,
  });

  final String? firstname;
  final String? lastname;
  int workspaceId = -1;

  @override
  String toString() => '${firstname ?? ''}${(lastname ?? '').isNotEmpty ? ' ' : ''}${lastname ?? ''}';
}
