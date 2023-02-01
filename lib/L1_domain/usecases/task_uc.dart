// Copyright (c) 2022. Alexandr Moroz

import '../entities/member.dart';
import '../entities/task.dart';
import '../repositories/abs_api_task_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class TaskUC {
  TaskUC({required this.repo});

  final AbstractApiTaskRepo repo;

  Future<List<Task>> getRoots(int wsId) async => await repo.getAll(wsId);
  Future<Iterable<Member>> getTaskMembers(int wsId, int taskId) async => await repo.getMembers(wsId, taskId);

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
