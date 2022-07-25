// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Person extends Emailable {
  Person({
    required int id,
    required this.workspaceId,
    required String email,
    this.firstname,
    this.lastname,
  }) : super(id: id, email: email);

  final String? firstname;
  final String? lastname;
  final int workspaceId;

  @override
  String toString() => '${firstname ?? ''}${(lastname ?? '').isNotEmpty ? ' ' : ''}${lastname ?? ''}';
}
