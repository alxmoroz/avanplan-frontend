// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/repositories/abs_api_ws_repo.dart';
import '../mappers/task.dart';
import '../services/api.dart';

class TasksRepo extends AbstractApiWSRepo<Task> {
  o_api.TasksApi get api => openAPI.getTasksApi();

  @override
  Future<List<Task>> getAll(int wsId) async {
    final List<Task> tasks = [];
    final response = await api.getRootTasksV1TasksGet(wsId: wsId);
    if (response.statusCode == 200) {
      for (o_api.TaskGet t in response.data?.toList() ?? []) {
        tasks.add(t.task(wsId: wsId));
      }
    }
    return tasks;
  }

  @override
  Future<Task?> save(Task data) async {
    final wsId = data.wsId;
    final qBuilder = o_api.TaskUpsertBuilder()
      ..id = data.id
      ..assigneeId = data.assignee?.id
      ..authorId = data.author?.id
      ..statusId = data.status?.id
      ..estimate = data.estimate
      ..parentId = data.parent?.id
      ..title = data.title
      ..description = data.description
      ..closed = data.closed
      ..startDate = data.startDate?.toUtc()
      ..closedDate = data.closedDate?.toUtc()
      ..dueDate = data.dueDate?.toUtc()
      ..type = data.type;

    final response = await api.upsertTaskV1TasksPost(taskUpsert: qBuilder.build(), wsId: wsId);
    Task? task;
    if (response.statusCode == 201) {
      task = response.data?.task(wsId: wsId, parent: data.parent);
    }
    return task;
  }

  @override
  Future<bool> delete(Task data) async {
    final response = await api.deleteTaskV1TasksTaskIdDelete(taskId: data.id!, wsId: data.wsId);
    return response.statusCode == 200 && response.data?.asNum == 1;
  }
}
