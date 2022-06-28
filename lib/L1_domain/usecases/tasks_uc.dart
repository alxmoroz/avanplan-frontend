// Copyright (c) 2022. Alexandr Moroz

import '../api_schema/task_upsert.dart';
import '../entities/element_of_work.dart';
import '../repositories/abs_api_repo.dart';

class TasksUC {
  TasksUC({required this.repo});

  final AbstractApiRepo<ElementOfWork, TaskUpsert> repo;

  Future<ElementOfWork?> save(TaskUpsert data) async {
    ElementOfWork? task;
    // TODO: внутр. exception?
    if (data.title.trim().isNotEmpty) {
      task = await repo.save(data);
    }
    return task;
  }

  Future<ElementOfWork?> delete({required ElementOfWork task}) async {
    final deletedRows = await repo.delete(task.id);
    // TODO: внутр. exception?
    if (deletedRows) {
      task.deleted = true;
    }
    return task;
  }
}
