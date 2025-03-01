// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as o_api;

import '../../L1_domain/entities/task_repeat.dart';

extension TaskRepeatMapper on o_api.TaskRepeatGet {
  TaskRepeat repeat(int wsId) => TaskRepeat(
        id: id,
        wsId: wsId,
        taskId: taskId,
        periodType: periodType,
        periodLength: periodLength,
        daysList: daysList,
      );
}
