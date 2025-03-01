// Copyright (c) 2024. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as o_api;

import '../../L1_domain/entities/task_repeat.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../mappers/task_repeat.dart';
import '../services/api.dart';

class TaskRepeatsRepo extends AbstractApiRepo<TaskRepeat, TaskRepeat> {
  o_api.TaskRepeatsApi get _api => avanplanApi.getTaskRepeatsApi();

  @override
  Future<TaskRepeat?> save(TaskRepeat data) async {
    final b = o_api.TaskRepeatUpsertBuilder()
      ..id = data.id
      ..taskId = data.taskId
      ..periodType = data.periodType
      ..periodLength = data.periodLength
      ..daysList = data.daysList;

    final response = await _api.upsertRepeat(
      wsId: data.wsId,
      taskId: data.taskId,
      taskRepeatUpsert: b.build(),
    );

    final resData = response.data;
    if (resData != null) {
      if (data.id == null) {
        data = resData.repeat(data.wsId);
      }
      return data;
    } else {
      return null;
    }
  }

  @override
  Future<TaskRepeat?> delete(TaskRepeat data) async {
    final response = await _api.deleteRepeat(
      wsId: data.wsId,
      taskId: data.taskId,
      repeatId: data.id!,
    );
    return response.data == true ? data : null;
  }
}
