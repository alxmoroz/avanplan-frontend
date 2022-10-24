// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../../L3_app/extra/api.dart';
import '../mappers/task_type.dart';

class TaskTypesRepo extends AbstractApiRepo<TaskType> {
  o_api.TasksApi get api => openAPI.getTasksApi();

  @override
  Future<List<TaskType>> getAll([dynamic query]) async {
    final response = await api.getTasksTypesV1TasksTypesGet();
    final List<TaskType> types = [];
    if (response.statusCode == 200) {
      for (o_api.TaskTypeGet st in response.data?.toList() ?? []) {
        types.add(st.type);
      }
    }
    return types;
  }

  @override
  Future<TaskType?> save(dynamic data) => throw UnimplementedError();

  @override
  Future<bool> delete(int? id) => throw UnimplementedError();
}
