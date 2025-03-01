// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as api;

import '../../L1_domain/entities/task_source.dart';
import '../../L1_domain/entities_extensions/task_source.dart';

extension TaskSourceMapper on api.TaskSourceGet {
  TaskSource get taskSource => TaskSource(
        id: id,
        sourceId: sourceId,
        code: code,
        rootCode: rootCode,
        urlString: url,
        updatedOn: updatedOn,
        keepConnection: keepConnection ?? false,
        state: tsStateFromStr(state),
        stateDetails: stateDetails,
      );
}

extension TaskSourceImportMapper on api.TaskSource {
  TaskSourceRemote get taskSourceRemote => TaskSourceRemote(
        sourceId: sourceId,
        code: code,
        rootCode: rootCode,
        urlString: url ?? '',
        updatedOn: updatedOn,
        keepConnection: keepConnection ?? false,
      );
}
