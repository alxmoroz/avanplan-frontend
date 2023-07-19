// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';
import '../entities/workspace.dart';
import '../repositories/abs_ws_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class TaskUC {
  TaskUC(this.repo);

  final AbstractWSRepo<Task> repo;

  Future<Iterable<Task>> getRoots(Workspace ws) async => await repo.getAll(ws);

  Future<Task?> save(Workspace ws, Task t) async => await repo.save(ws, t);

  Future<Task> delete(Workspace ws, Task t) async {
    if (t.id != null) {
      final deletedRows = await repo.delete(ws, t);
      // TODO: внутр. exception?
      if (deletedRows) {
        t.removed = true;
      }
    }
    return t;
  }
}
