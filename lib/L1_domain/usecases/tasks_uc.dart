// Copyright (c) 2022. Alexandr Moroz

import '../api_schema/task_schema.dart';
import '../entities/task.dart';
import '../repositories/abs_api_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class TasksUC {
  TasksUC({required this.repo});

  final AbstractApiRepo<Task, TaskUpsert, TaskQuery> repo;

  Future<List<Task>> getTasks(int wsId, int? parentId) async => await repo.getAll(TaskQuery(workspaceId: wsId, parentId: parentId));

  Future<List<Task>> getRoots(int wsId) async => await getTasks(wsId, null);

  Future<Task?> save(TaskUpsert data) async {
    Task? task;
    // TODO: внутр. exception?
    if (data.title.trim().isNotEmpty) {
      task = await repo.save(data);
    }
    return task;
  }

  Future<Task?> delete({required Task task}) async {
    final deletedRows = await repo.delete(task.id);
    // TODO: внутр. exception?
    if (deletedRows) {
      task.deleted = true;
    }
    return task;
  }
}
