// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';
import '../repositories/abs_api_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class TaskUC {
  TaskUC(this.repo);

  final AbstractApiRepo<Task> repo;

  Future<Task?> save(Task t) async => await repo.save(t);
  Future<bool> delete(Task t) async => await repo.delete(t);
}
