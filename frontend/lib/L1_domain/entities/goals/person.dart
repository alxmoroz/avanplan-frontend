// Copyright (c) 2022. Alexandr Moroz

import '../base_entity.dart';

class Person extends RPersistable {
  Person({
    required int id,
    required this.workspaceId,
    required this.email,
    this.firstname,
    this.lastname,
  }) : super(id: id);

  final String? firstname;
  final String? lastname;
  final String email;
  final int workspaceId;

  @override
  String toString() => '${firstname ?? ''}${(lastname ?? '').isNotEmpty ? ' ' : ''}${lastname ?? ''}';
}
