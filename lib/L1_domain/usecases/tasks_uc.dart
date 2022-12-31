// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';
import '../repositories/abs_api_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class TasksUC {
  TasksUC({required this.repo});

  final AbstractApiRepo<Task> repo;

  Future<List<Task>> getTasks(int wsId, int? parentId) async => await repo.getAll(TaskQuery(workspaceId: wsId, parentId: parentId));
  Future<List<Task>> getRoots(int wsId) async => await getTasks(wsId, null);

  Future<Task?> save(Task t) async {
    Task? task;
    // TODO: внутр. exception?
    if (t.title.trim().isNotEmpty) {
      task = await repo.save(t);
    }
    return task;
  }

  Future<Task> delete({required Task t}) async {
    if (t.id != null) {
      final deletedRows = await repo.delete(t.id!);
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
