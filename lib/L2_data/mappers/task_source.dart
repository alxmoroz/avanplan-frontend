// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/task_source.dart';
import 'source.dart';

extension TaskSourceMapper on api.TaskSourceGet {
  TaskSource get taskSource => TaskSource(
        id: id,
        code: code,
        keepConnection: keepConnection ?? true,
        source: source_.source,
      );
}
