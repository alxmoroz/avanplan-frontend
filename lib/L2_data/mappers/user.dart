// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/user.dart';

extension UserMapper on api.User {
  User get user => User(
        id: id,
        email: email,
        fullName: fullName ?? '',
        roles: roleCodes ?? [],
        permissions: permissionCodes ?? [],
      );
}
