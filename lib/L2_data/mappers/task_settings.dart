// Copyright (c) 2025. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as o_api;

import '../../L1_domain/entities/task_settings.dart';

extension TaskSettingsMapper on o_api.TaskSettingsGet {
  TaskSettings get settings => TaskSettings(
        id: id,
        taskId: taskId,
        code: TSCode.fromString(code),
        value: value,
      );
}
