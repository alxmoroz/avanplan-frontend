// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../../L3_app/presenters/task_tree.dart';
import '../mappers/task.dart';
import '../services/api.dart';

class TaskRepo extends AbstractApiRepo<Task> {
  o_api.TasksApi get api => openAPI.getTasksApi();

  @override
  Future<Task?> save(Task data) async {
    final qBuilder = o_api.TaskUpsertBuilder()
      ..id = data.id
      ..createdOn = data.createdOn?.toUtc()
      ..taskSourceId = data.taskSource?.id
      ..assigneeId = data.assigneeId
      ..authorId = data.authorId
      ..statusId = data.statusId
      ..estimate = data.estimate
      ..parentId = data.parentId
      ..title = data.title
      ..description = data.description
      ..closed = data.closed
      ..startDate = data.startDate?.toUtc()
      ..closedDate = data.closedDate?.toUtc()
      ..dueDate = data.dueDate?.toUtc()
      ..type = data.type;

    final changes = (await api.taskUpsertV1TasksPost(
      taskUpsert: qBuilder.build(),
      wsId: data.ws.id!,
      permissionTaskId: data.project?.id,
    ))
        .data;

    final et = changes?.updatedTask.task(data.ws);
    final affected = changes?.affectedTasks.map((t) => t.task(data.ws));

    return et;
  }

  @override
  Future<bool> delete(Task data) async {
    final changes = (await api.deleteV1TasksTaskIdDelete(
      taskId: data.id!,
      wsId: data.ws.id!,
      permissionTaskId: data.project?.id,
    ))
        .data;
    final affected = changes?.affectedTasks.map((t) => t.task(data.ws));
    return changes != null;
  }
}
