// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../mappers/task.dart';
import 'api.dart';

// TODO: для всех подобных репозиториев: развязать узел зависимости от 3 уровня за счёт инициализации openApi в конструктор репы

class TasksRepo extends AbstractApiRepo<Task> {
  o_api.TasksApi get api => openAPI.getTasksApi();

  @override
  Future<List<Task>> getAll([dynamic query]) async {
    final List<Task> tasks = [];
    final response = await api.getRootTasksV1TasksGet(wsId: query!.workspaceId);
    if (response.statusCode == 200) {
      for (o_api.TaskGet t in response.data?.toList() ?? []) {
        tasks.add(t.task());
      }
    }
    return tasks;
  }

  @override
  Future<Task?> save(Task data) async {
    final qBuilder = o_api.TaskUpsertBuilder()
      ..workspaceId = data.workspaceId
      ..id = data.id
      ..statusId = data.status?.id
      ..parentId = data.parent?.id
      ..title = data.title
      ..description = data.description
      ..closed = data.closed
      ..startDate = data.startDate?.toUtc()
      ..dueDate = data.dueDate?.toUtc()
      ..typeId = data.type?.id;

    final response = await api.upsertTaskV1TasksPost(taskUpsert: qBuilder.build());
    Task? task;
    if (response.statusCode == 201) {
      task = response.data?.task(data.parent);
    }
    return task;
  }

  @override
  Future<bool> delete(int id) async {
    final response = await api.deleteTaskV1TasksTaskIdDelete(taskId: id);
    return response.statusCode == 200 && response.data?.asNum == 1;
  }
}
