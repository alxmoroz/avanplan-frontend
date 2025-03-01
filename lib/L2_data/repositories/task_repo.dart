// Copyright (c) 2024. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as o_api;
import 'package:built_collection/built_collection.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/repositories/abs_task_repo.dart';
import '../mappers/task.dart';
import '../services/api.dart';

class TaskRepo extends AbstractTaskRepo {
  o_api.WSTasksApi get api => avanplanApi.getWSTasksApi();

  @override
  Future<Iterable<Task>> tasksList(int wsId, Iterable<int> taskIds) async {
    final data = (await api.tasksList(
      wsId: wsId,
      requestBody: BuiltList.of(taskIds),
    ))
        .data;
    return data?.map((t) => t.task(wsId)) ?? [];
  }

  @override
  Future<TaskNode?> taskNode(int wsId, int taskId, {bool? closed, bool? fullTree}) async {
    final node = (await api.taskNode(
      wsId: wsId,
      taskId: taskId,
      closed: closed,
      fullTree: fullTree,
    ))
        .data;
    return node != null
        ? TaskNode(
            node.task.task(wsId),
            node.parents.map((t) => t.task(wsId)),
            node.subtasks.map((t) => t.task(wsId)),
          )
        : null;
  }

  @override
  Future<TasksChanges?> save(Task data) async {
    final qBuilder = o_api.TaskUpsertBuilder()
      ..id = data.id
      ..category = data.category
      ..icon = data.icon
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
      ..type = data.type.name;

    final changes = (await api.upsertTask(
      taskUpsert: qBuilder.build(),
      wsId: data.wsId,
      taskId: data.id,
      prevPosition: data.prevPosition,
      nextPosition: data.nextPosition,
    ))
        .data;

    return changes != null
        ? TasksChanges(
            changes.updatedTask.task(data.wsId),
            changes.affectedTasks.map((t) => t.task(data.wsId)),
          )
        : null;
  }

  @override
  Future<TasksChanges?> duplicate(Task data) async {
    final changes = (await api.duplicateTask(
      wsId: data.wsId,
      srcWsId: data.wsId,
      taskId: data.id!,
    ))
        .data;

    return changes != null
        ? TasksChanges(
            changes.updatedTask.task(data.wsId),
            changes.affectedTasks.map((t) => t.task(data.wsId)),
          )
        : null;
  }

  @override
  Future<TasksChanges?> repeat(Task src) async {
    final changes = (await api.repeatTask(
      wsId: src.wsId,
      srcWsId: src.wsId,
      taskId: src.id!,
    ))
        .data;

    return changes != null
        ? TasksChanges(
            changes.updatedTask.task(src.wsId),
            changes.affectedTasks.map((t) => t.task(src.wsId)),
          )
        : null;
  }

  @override
  Future<TasksChanges?> move(Task src, Task destination) async {
    final changes = (await api.moveTask(
      srcWsId: src.wsId,
      srcTaskId: src.id!,
      wsId: destination.wsId,
      taskId: destination.id!,
    ))
        .data;

    return changes != null
        ? TasksChanges(
            changes.updatedTask.task(destination.wsId),
            changes.affectedTasks.map((t) => t.task(destination.wsId)),
          )
        : null;
  }

  @override
  Future<TasksChanges?> delete(Task data) async {
    final changes = (await api.deleteTask(
      taskId: data.id!,
      wsId: data.wsId,
    ))
        .data;
    return changes != null
        ? TasksChanges(
            changes.updatedTask.task(data.wsId),
            changes.affectedTasks.map((t) => t.task(data.wsId)),
          )
        : null;
  }

  @override
  Future<bool> unlink(Task project) async {
    final response = await api.unlinkTask(
      wsId: project.wsId,
      taskId: project.id!,
    );
    return response.data == true;
  }
}
