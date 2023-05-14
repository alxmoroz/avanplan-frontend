// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';
import '../repositories/abs_ws_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class TaskUC {
  TaskUC(this.repo);

  final AbstractWSRepo<Task> repo;

  Future<Iterable<Task>> getRoots(int wsId) async => await repo.getAll(wsId);

  Future<Task?> save(Task t) async => await repo.save(t);

  Future<Task> delete(Task t) async {
    if (t.id != null) {
      final deletedRows = await repo.delete(t);
      // TODO: внутр. exception?
      if (deletedRows) {
        t.deleted = true;
      }
    }
    return t;
  }
}
