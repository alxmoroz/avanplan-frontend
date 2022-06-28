// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/api_schema/task_upsert.dart';
import '../../L1_domain/entities/element_of_work.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../../L3_app/extra/services.dart';
import '../mappers/task.dart';

class TasksRepo extends AbstractApiRepo<ElementOfWork, TaskUpsert> {
  TasksApi get api => openAPI.getTasksApi();

  @override
  Future<List<ElementOfWork>> getAll() => throw UnimplementedError();

  @override
  Future<ElementOfWork?> save(TaskUpsert data) async {
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
    ElementOfWork? task;
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
