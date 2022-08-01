// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/task_import.dart';

extension TaskImportMapper on api.TaskImport {
  TaskImport get taskImport => TaskImport(
        title: title,
        description: description ?? '',
        code: taskSource.code,
      );
}
