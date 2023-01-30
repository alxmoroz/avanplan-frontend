// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Member extends Emailable {
  Member({
    required super.id,
    required super.email,
    required this.workspaceId,
    this.fullName,
  });

  final String? fullName;
  final int workspaceId;

  @override
  String toString() => '${fullName ?? email}';
}
