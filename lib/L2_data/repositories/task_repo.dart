// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../mappers/task.dart';
import '../services/api.dart';

class TaskRepo extends AbstractApiRepo<TasksChanges, Task> {
  o_api.TasksApi get api => openAPI.getTasksApi();

  @override
  Future<TasksChanges> save(Task data) async {
    final qBuilder = o_api.TaskUpsertBuilder()
      ..id = data.id
      ..createdOn = data.createdOn?.toUtc()
      ..taskSourceId = data.taskSource?.id
      ..assigneeId = data.assigneeId
      ..authorId = data.authorId
      ..projectStatusId = data.projectStatusId
      ..estimate = data.estimate
      ..parentId = data.parentId
      ..title = data.title
      ..description = data.description
      ..closed = data.closed
      ..startDate = data.startDate?.toUtc()
      ..closedDate = data.closedDate?.toUtc()
      ..dueDate = data.dueDate?.toUtc()
      ..type = data.type;

    final changes = (await api.upsertTask(
      taskUpsert: qBuilder.build(),
      wsId: data.wsId,
      taskId: data.id,
    ))
        .data;

    return TasksChanges(
      changes?.updatedTask.task(data.wsId),
      changes?.affectedTasks.map((t) => t.task(data.wsId)) ?? [],
    );
  }

  @override
  Future<TasksChanges> copy(Task data) async {
    final changes = (await api.copyTask(
      wsId: data.wsId,
      taskId: data.id!,
    ))
        .data;

    return TasksChanges(
      changes?.updatedTask.task(data.wsId),
      changes?.affectedTasks.map((t) => t.task(data.wsId)) ?? [],
    );
  }

  @override
  Future<TasksChanges> delete(Task data) async {
    final changes = (await api.deleteTask(
      taskId: data.id!,
      wsId: data.wsId,
    ))
        .data;
    return TasksChanges(
      changes?.updatedTask.task(data.wsId),
      changes?.affectedTasks.map((t) => t.task(data.wsId)) ?? [],
    );
  }
}
