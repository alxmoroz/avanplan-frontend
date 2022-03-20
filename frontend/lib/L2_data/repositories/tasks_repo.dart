// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/goals/task.dart';
import '../../L1_domain/repositories/abstract_tasks_repo.dart';
import '../../L3_app/extra/services.dart';
import '../mappers/task.dart';

class TasksRepo extends AbstractTasksRepo {
  TasksApi get api => openAPI.getTasksApi();

  @override
  Future<Task?> saveTask({
    required int goalId,
    required int? id,
    required int? parentId,
    required String title,
    required String description,
    required DateTime? dueDate,
  }) async {
    //TODO: не учитываются возможные ошибки! Нет обработки 403 и т.п.

    final builder = TaskSchemaUpsertBuilder()
      ..id = id
      ..goalId = goalId
      ..parentId = parentId
      ..title = title
      ..description = description
      ..dueDate = dueDate?.toUtc();

    final response = await api.upsertTaskApiV1TasksPost(taskSchemaUpsert: builder.build());
    Task? task;
    if (response.statusCode == 201) {
      task = response.data?.task;
    }
    return task;
  }

  @override
  Future<bool> deleteTask(int id) async {
    final response = await api.deleteTaskApiV1TasksTaskIdDelete(taskId: id);
    return response.statusCode == 200 && response.data?.asNum == 1;
  }
}
