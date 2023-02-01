// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan/L1_domain/entities/task_role.dart';

import 'user.dart';

class Member extends User {
  Member({
    required super.id,
    required super.email,
    required super.fullName,
    required this.wsId,
    required this.userId,
  });

  final int wsId;
  final int? userId;

  List<TaskRole> roles = [];

  @override
  String toString() => '${fullName ?? email}';
}
