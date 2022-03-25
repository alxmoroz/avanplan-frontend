// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/goals/task.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../../L3_app/extra/services.dart';
import '../mappers/task.dart';

class TasksRepo extends AbstractApiRepo<Task> {
  TasksApi get api => openAPI.getTasksApi();

  @override
  Future<List<Task>> getAll() {
    throw UnimplementedError();
  }

  @override
  Future<Task?> save(dynamic params) async {
    final data = params as TaskSchemaUpsert;
    //TODO: не учитываются возможные ошибки! Нет обработки 403 и т.п.

    final response = await api.upsertTaskApiV1TasksPost(taskSchemaUpsert: data);
    Task? task;
    if (response.statusCode == 201) {
      task = response.data?.task;
    }
    return task;
  }

  @override
  Future<bool> delete(int id) async {
    final response = await api.deleteTaskApiV1TasksTaskIdDelete(taskId: id);
    return response.statusCode == 200 && response.data?.asNum == 1;
  }
}
