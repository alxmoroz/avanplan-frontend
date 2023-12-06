// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';
import '../repositories/abs_api_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class TaskUC {
  TaskUC(this.repo);

  final AbstractApiRepo<TasksChanges, Task> repo;

  Future<TasksChanges?> save(Task t) async => await repo.save(t);
  Future<TasksChanges?> copy(Task t) async => await repo.copy(t);
  Future<TasksChanges?> delete(Task t) async => await repo.delete(t);
}
