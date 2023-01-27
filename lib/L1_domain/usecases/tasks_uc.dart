// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';
import '../repositories/abs_api_ws_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class TasksUC {
  TasksUC({required this.repo});

  final AbstractApiWSRepo<Task> repo;

  Future<List<Task>> getRoots(int wsId) async => await repo.getAll(wsId);

  Future<Task?> save(Task t) async {
    Task? task;
    // TODO: внутр. exception?
    if (t.title.trim().isNotEmpty) {
      task = await repo.save(t);
    }
    return task;
  }

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

// class TaskTypesUC {
//   TaskTypesUC({required this.repo});
//
//   final AbstractApiRepo<TaskType> repo;
//
//   Future<List<TaskType>> getAll() async => await repo.getAll();
// }
