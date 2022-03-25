// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../entities/goals/task.dart';
import '../repositories/abs_api_repo.dart';

class TasksUC {
  TasksUC({required this.repo});

  final AbstractApiRepo<Task> repo;

  Future<Task?> save({
    required int goalId,
    required int? id,
    required int? statusId,
    required int? parentId,
    required String title,
    required String description,
    required DateTime? dueDate,
  }) async {
    Task? task;
    // TODO: внутр. exception?
    if (title.trim().isNotEmpty) {
      final builder = TaskSchemaUpsertBuilder()
        ..goalId = goalId
        ..id = id
        ..statusId = statusId
        ..parentId = parentId
        ..title = title
        ..description = description
        ..dueDate = dueDate?.toUtc();

      task = await repo.save(builder.build());
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
