// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/api_schema/base_upsert_schema.dart';
import '../../L1_domain/entities/goals/task_status.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../../L3_app/extra/services.dart';
import '../mappers/task_status.dart';

class TaskStatusesRepo extends AbstractApiRepo<TaskStatus, BaseUpsert> {
  TasksApi get api => openAPI.getTasksApi();

  @override
  Future<List<TaskStatus>> getAll() async {
    final response = await api.getTaskStatusesApiV1TasksStatusesGet();

    final List<TaskStatus> statuses = [];
    if (response.statusCode == 200) {
      for (TaskStatusSchemaGet ts in response.data?.toList() ?? []) {
        statuses.add(ts.status);
      }
    }
    return statuses;
  }

  @override
  Future<TaskStatus?> save(dynamic data) {
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) {
    throw UnimplementedError();
  }
}
