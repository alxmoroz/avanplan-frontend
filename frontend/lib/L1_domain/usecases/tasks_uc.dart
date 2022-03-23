// Copyright (c) 2022. Alexandr Moroz

import '../entities/goals/goal.dart';
import '../entities/goals/task.dart';
import '../repositories/abstract_tasks_repo.dart';

class TasksUC {
  TasksUC({required this.repo});

  final AbstractTasksRepo repo;

  Future<Task?> saveTask({
    required int? id,
    required int? parentId,
    required String title,
    required String description,
    required DateTime? dueDate,
    required Goal goal,
  }) async {
    Task? task;
    // TODO: внутр. exception?
    if (title.trim().isNotEmpty) {
      task = await repo.saveTask(goalId: goal.id, id: id, parentId: parentId, title: title, description: description, dueDate: dueDate);

      if (task != null) {
        final index = goal.tasks.indexWhere((t) => t.id == id);
        if (index >= 0) {
          goal.tasks[index] = task;
        } else {
          goal.tasks.add(task);
        }
      }
    }
    return task;
  }

  Future<Task?> deleteTask({
    required Task task,
    required Goal goal,
  }) async {
    final deletedRows = await repo.deleteTask(task.id);
    // TODO: внутр. exception?
    if (deletedRows) {
      task.deleted = true;
      goal.tasks.remove(task);
    }
    return task;
  }
}
