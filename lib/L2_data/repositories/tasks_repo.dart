// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/api_schema/task_schema.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../../L1_domain/system/errors.dart';
import '../../L3_app/extra/services.dart';
import '../mappers/task.dart';

// TODO: для всех подобных репозиториев: развязать узел зависимости от 3 уровня за счёт инициализации openApi в конструктор репы

class TasksRepo extends AbstractApiRepo<Task, TaskUpsert, TaskQuery> {
  TasksApi get api => openAPI.getTasksApi();

  @override
  Future<List<Task>> getAll([TaskQuery? query]) async {
    final List<Task> tasks = [];
    try {
      final response = await api.getRootTasksV1TasksGet(wsId: query!.workspaceId);
      if (response.statusCode == 200) {
        for (TaskSchemaGet t in response.data?.toList() ?? []) {
          tasks.add(t.task);
        }
      }
    } catch (e) {
      throw MTException(code: 'task_error_get_root_tasks', detail: e.toString());
    }

    return tasks;
  }

  @override
  Future<Task?> save(TaskUpsert data) async {
    //TODO: не учитываются возможные ошибки! Нет обработки 403 и т.п.
    final qBuilder = TaskSchemaUpsertBuilder()
      ..workspaceId = data.workspaceId
      ..id = data.id
      ..statusId = data.statusId
      ..parentId = data.parentId
      ..title = data.title
      ..description = data.description
      ..closed = data.closed
      ..dueDate = data.dueDate?.toUtc();

    final response = await api.upsertTaskV1TasksPost(taskSchemaUpsert: qBuilder.build());
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
