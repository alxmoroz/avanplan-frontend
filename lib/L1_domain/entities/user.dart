// Copyright (c) 2024. Alexandr Moroz

import 'person.dart';
import 'user_activity.dart';

class User extends Person {
  User({
    required super.id,
    required super.updatedOn,
    required super.email,
    required super.fullName,
    required super.roles,
    required super.permissions,
    required this.wsId,
    required this.activities,
    required this.hasAvatar,
  });

  final int wsId;
  final Iterable<UActivity> activities;
  final bool hasAvatar;

  static User get dummy => User(
        id: null,
        updatedOn: DateTime.now(),
        email: '',
        fullName: '',
        roles: [],
        permissions: [],
        wsId: -1,
        activities: [],
        hasAvatar: false,
      );
}
