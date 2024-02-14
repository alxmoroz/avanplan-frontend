// Copyright (c) 2022. Alexandr Moroz

import 'person.dart';
import 'user_activity.dart';

class WSMember extends Person {
  WSMember({
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

  static WSMember get dummy => WSMember(id: null, email: '', fullName: '', roles: [], permissions: [], wsId: -1, activities: []);
}
