// Copyright (c) 2024. Alexandr Moroz

import 'user_activity.dart';
import 'ws_member.dart';

class User extends WSMember {
  User({
    required super.id,
    required super.email,
    required super.fullName,
    required super.roles,
    required super.permissions,
    required super.wsId,
    required this.activities,
    required this.hasAvatar,
    super.updatedOn,
  });

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
