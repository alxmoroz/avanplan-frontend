// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/task_import.dart';

extension TaskImportMapper on TaskImportRemoteSchemaGet {
  TaskImport get goalImport => TaskImport(
        code: remoteCode,
        title: title,
        description: description ?? '',
        dueDate: dueDate,
        closed: closed,
      );
}
