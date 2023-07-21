// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/task_source.dart';

extension TaskSourceMapper on api.TaskSourceGet {
  TaskSource get taskSource => TaskSource(
        id: id,
        code: code,
        rootCode: rootCode,
        keepConnection: keepConnection,
        sourceId: sourceId,
        urlString: url,
        updatedOn: updatedOn,
      );
}

extension TaskSourceImportMapper on api.TaskSource {
  TaskSourceImport get taskSourceImport => TaskSourceImport(
        code: code,
        rootCode: rootCode,
        keepConnection: keepConnection,
        updatedOn: updatedOn,
      );
}
