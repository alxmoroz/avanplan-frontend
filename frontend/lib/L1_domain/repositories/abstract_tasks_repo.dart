// Copyright (c) 2022. Alexandr Moroz

import '../entities/goals/task.dart';

abstract class AbstractTasksRepo {
  Future<Task?> saveTask({
    required int goalId,
    required int? id,
    required int? parentId,
    required String title,
    required String description,
    required DateTime dueDate,
  });
  Future<bool> deleteTask(int id);
}
