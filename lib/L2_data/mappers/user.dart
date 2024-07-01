// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/user.dart';
import 'user_activity.dart';

extension UserMapper on api.User {
  User user(int wsId) => User(
        wsId: wsId,
        id: id,
        updatedOn: updatedOn?.toLocal(),
        email: email,
        fullName: fullName ?? '',
        roles: roleCodes ?? [],
        permissions: permissionCodes ?? [],
        activities: [],
        hasAvatar: hasAvatar ?? false,
      );
}

extension MyUserMapper on api.MyUser {
  User myUser(int wsId) => User(
        wsId: wsId,
        id: id,
        updatedOn: updatedOn?.toLocal(),
        email: email,
        fullName: fullName ?? '',
        roles: [],
        permissions: [],
        activities: activities.map((a) => a.activity),
        hasAvatar: hasAvatar ?? false,
      );
}
