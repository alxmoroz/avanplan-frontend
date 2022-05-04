// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/api_schema/task.dart';
import '../../L1_domain/entities/goals/task.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../../L3_app/extra/services.dart';
import '../mappers/task.dart';

class TasksRepo extends AbstractApiRepo<Task, TaskUpsert> {
  TasksApi get api => openAPI.getTasksApi();

  @override
  Future<List<Task>> getAll() => throw UnimplementedError();

  @override
  Future<Task?> save(TaskUpsert data) async {
    //TODO: не учитываются возможные ошибки! Нет обработки 403 и т.п.
    final builder = TaskSchemaUpsertBuilder()
      ..goalId = data.goalId
      ..id = data.id
      ..statusId = data.statusId
      ..parentId = data.parentId
      ..title = data.title
      ..description = data.description
      ..closed = data.closed
      ..dueDate = data.dueDate?.toUtc();

    final response = await api.upsertTaskV1TasksPost(taskSchemaUpsert: builder.build());
    Task? task;
    if (response.statusCode == 201) {
      task = response.data?.task;
    }
    return task;
  }

  @override
  Future<bool> delete(int id) async {
    final response = await api.deleteTaskV1TasksTaskIdDelete(taskId: id);
    return response.statusCode == 200 && response.data?.asNum == 1;
  }
}
