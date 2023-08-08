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
  Future<Task?> save(Workspace ws, Task data) async {
    final qBuilder = o_api.TaskUpsertBuilder()
      ..id = data.id
      ..createdOn = data.createdOn?.toUtc()
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

    final t = (await api.taskUpsertV1TasksPost(
      taskUpsert: qBuilder.build(),
      wsId: ws.id!,
      permissionTaskId: data.project?.id,
    ))
        .data
        ?.task(ws: ws, parent: data.parent);

    if (t != null) {
      if (t.tasks.isEmpty) {
        t.tasks = data.tasks;
      }
      if (t.members.isEmpty) {
        t.members = data.members;
      }
      if (t.projectStatuses.isEmpty) {
        t.projectStatuses = data.projectStatuses;
      }
      if (t.notes.isEmpty) {
        t.notes = data.notes;
      }
    }

    if (t != null && data.parent != null) {
      if (data.id == null) {
        data.parent!.tasks.add(t);
      } else {
        final index = data.parent!.tasks.indexWhere((t) => t.ws.id == t.ws.id && t.id == t.id);
        if (index > -1) {
          data.parent!.tasks[index] = t;
        }
      }
    }

    return t;
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
