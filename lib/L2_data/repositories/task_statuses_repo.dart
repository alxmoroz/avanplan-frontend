// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/api_schema/base_upsert.dart';
import '../../L1_domain/entities/task_status.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../../L3_app/extra/services.dart';

class TaskStatusesRepo extends AbstractApiRepo<TaskStatus, BaseUpsert> {
  TasksApi get api => openAPI.getTasksApi();

  @override
  Future<List<TaskStatus>> getAll() async => throw UnimplementedError();

  @override
  Future<TaskStatus?> save(dynamic data) => throw UnimplementedError();

  @override
  Future<bool> delete(int id) => throw UnimplementedError();
}
