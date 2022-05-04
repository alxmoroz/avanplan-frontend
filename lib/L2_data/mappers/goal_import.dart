// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/goals/goal_import.dart';

extension GoalMapper on GoalImportRemoteSchemaGet {
  GoalImport get goalImport => GoalImport(
        code: remoteCode,
        title: title,
        description: description ?? '',
        dueDate: dueDate,
        closed: closed,
      );
}
