// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';
import '../repositories/abs_task_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class TaskUC {
  TaskUC(this.repo);

  final AbstractTaskRepo repo;

  Future<TasksChanges?> save(Task t) async => await repo.save(t);
  Future<TasksChanges?> duplicate(Task t) async => await repo.duplicate(t);
  Future<TasksChanges?> move(Task src, Task destination) async => await repo.move(src, destination);
  Future<TasksChanges?> delete(Task t) async => await repo.delete(t);
}
