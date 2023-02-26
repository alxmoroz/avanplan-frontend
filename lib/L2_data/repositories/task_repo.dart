// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/repositories/abs_ws_repo.dart';
import '../../L1_domain/usecases/task_ext_level.dart';
import '../mappers/task.dart';
import '../services/api.dart';

class TaskRepo extends AbstractWSRepo<Task> {
  o_api.TasksApi get api => openAPI.getTasksApi();

  @override
  Future<Iterable<Task>> getAll(int wsId) async {
    final response = await api.projectsV1TasksGet(wsId: wsId);
    return response.data?.map((t) => t.task(wsId: wsId)) ?? [];
  }

  @override
  Future<Task?> save(Task data) async {
    final wsId = data.wsId;
    final qBuilder = o_api.TaskUpsertBuilder()
      ..id = data.id
      ..assigneeId = data.assigneeId
      ..authorId = data.authorId
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

    final response = await api.upsertV1TasksPost(
      taskUpsert: qBuilder.build(),
      wsId: wsId,
      permissionTaskId: data.project?.id,
    );
    return response.data?.task(wsId: wsId, parent: data.parent);
  }

  @override
  Future<bool> delete(Task data) async {
    final response = await api.deleteV1TasksTaskIdDelete(
      taskId: data.id!,
      wsId: data.wsId,
      permissionTaskId: data.project?.id,
    );
    return response.data == true;
  }
}
