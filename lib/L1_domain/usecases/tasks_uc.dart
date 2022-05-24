// Copyright (c) 2022. Alexandr Moroz

import '../api_schema/task_upsert.dart';
import '../entities/goals/task.dart';
import '../repositories/abs_api_repo.dart';

class TasksUC {
  TasksUC({required this.repo});

  final AbstractApiRepo<Task, TaskUpsert> repo;

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
