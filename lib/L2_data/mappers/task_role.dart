// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/task_role.dart';

extension TaskRoleMapper on TaskRoleGet {
  TaskRole get role => TaskRole(
        id: id,
        code: code.toLowerCase(),
      );
}
