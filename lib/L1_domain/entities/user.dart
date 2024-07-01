// Copyright (c) 2024. Alexandr Moroz

import 'dart:convert';

import 'package:crypto/crypto.dart';

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
  String get emailMD5 => md5.convert(utf8.encode(email)).toString();

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
