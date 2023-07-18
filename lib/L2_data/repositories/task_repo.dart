// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/entities_extensions/task_level.dart';
import '../../L1_domain/repositories/abs_ws_repo.dart';
import '../mappers/task.dart';
import '../services/api.dart';

class TaskRepo extends AbstractWSRepo<Task> {
  o_api.TasksApi get api => openAPI.getTasksApi();

  @override
  Future<Iterable<Task>> getAll(Workspace ws) async {
    final response = await api.projectsV1TasksGet(wsId: ws.id!);
    return response.data?.map((t) => t.task(ws: ws)) ?? [];
  }

  @override
  Future<Task?> save(Workspace ws, Task data) async {
    final qBuilder = o_api.TaskUpsertBuilder()
      ..id = data.id
      ..taskSourceId = data.taskSource?.id
      ..assigneeId = data.assigneeId
      ..authorId = data.authorId
      ..statusId = data.statusId
      ..estimate = data.estimate
      ..parentId = data.parent?.id
      ..title = data.title
      ..description = data.description
      ..closed = data.closed
      ..startDate = data.startDate?.toUtc()
      ..closedDate = data.closedDate?.toUtc()
      ..dueDate = data.dueDate?.toUtc()
      ..type = data.type;

    final response = await api.upsertV1TasksPost(
      taskUpsert: qBuilder.build(),
      wsId: ws.id!,
      permissionTaskId: data.project?.id,
    );

    final resData = response.data;
    if (resData != null) {
      if (data.id == null) {
        data = resData.task(ws: ws, parent: data.parent);
      }
      return data;
    } else {
      return null;
    }
  }

  @override
  Future<bool> delete(Workspace ws, Task data) async {
    final response = await api.deleteV1TasksTaskIdDelete(
      taskId: data.id!,
      wsId: ws.id!,
      permissionTaskId: data.project?.id,
    );
    return response.data == true;
  }
}
