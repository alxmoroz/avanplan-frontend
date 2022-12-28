// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/task_type.dart';

extension TaskTypeMapper on api.TaskTypeGet {
  TaskType get type => TaskType(
        id: id,
        title: title,
      );
}
