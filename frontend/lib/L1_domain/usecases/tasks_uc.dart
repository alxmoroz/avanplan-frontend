// Copyright (c) 2022. Alexandr Moroz

import '../entities/goals/task.dart';
import '../repositories/abstract_tasks_repo.dart';

class TasksUC {
  TasksUC({required this.repo});

  final AbstractTasksRepo repo;

  Future<Task?> saveTask({
    required int goalId,
    required int? id,
    required int? parentId,
    required String title,
    required String description,
    required DateTime? dueDate,
  }) async {
    Task? task;
    // TODO: внутр. exception?
    if (title.trim().isNotEmpty) {
      task = await repo.saveTask(goalId: goalId, id: id, parentId: parentId, title: title, description: description, dueDate: dueDate);
    }
    return task;
  }

  Future<Task?> deleteTask(Task task) async {
    final deletedRows = await repo.deleteTask(task.id);
    // TODO: внутр. exception?
    if (deletedRows) {
      task.deleted = true;
    }
    return task;
  }
}
