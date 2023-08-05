// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';
import '../entities/workspace.dart';
import '../repositories/abs_ws_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class TaskUC {
  TaskUC(this.repo);

  final AbstractWSRepo<Task> repo;

  Future<Task?> save(Workspace ws, Task t) async => await repo.save(ws, t);
  Future<bool> delete(Workspace ws, Task t) async => await repo.delete(ws, t);
}
