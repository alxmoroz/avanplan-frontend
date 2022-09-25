// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Person extends Emailable {
  Person({
    required super.id,
    required super.email,
    required this.workspaceId,
    this.firstname,
    this.lastname,
  });

  final String? firstname;
  final String? lastname;
  final int workspaceId;

  @override
  String toString() => '${firstname ?? ''}${(lastname ?? '').isNotEmpty ? ' ' : ''}${lastname ?? ''}';
}
