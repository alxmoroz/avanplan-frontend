// Copyright (c) 2022. Alexandr Moroz

import 'person.dart';
import 'user_activity.dart';

class User extends Person {
  User({
    required super.id,
    required super.email,
    required super.fullName,
    required super.roles,
    required super.permissions,
    required this.wsId,
    required this.activities,
  });

  final int wsId;
  final Iterable<UActivity> activities;
}
