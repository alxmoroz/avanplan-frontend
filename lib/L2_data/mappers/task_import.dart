// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/task_import.dart';

extension TaskImportMapper on TaskImportRemoteSchemaGet {
  TaskImport get taskImport => TaskImport(
        code: remoteCode,
        title: title,
        description: description ?? '',
        dueDate: dueDate,
        closed: closed,
      );
}
