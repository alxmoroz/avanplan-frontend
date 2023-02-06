// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/role.dart';

extension TaskRoleMapper on RoleGet {
  Role get role => Role(
        id: id,
        code: code.toLowerCase(),
      );
}
