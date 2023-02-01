// Copyright (c) 2022. Alexandr Moroz

import '../entities/member.dart';
import '../entities/task.dart';
import '../repositories/abs_api_task_member_role_repo.dart';
import '../repositories/abs_api_ws_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class TaskUC {
  TaskUC({
    required this.taskRepo,
    required this.tmRoleRepo,
  });

  final AbstractApiWSRepo<Task> taskRepo;
  final AbstractApiTaskMemberRoleRepo tmRoleRepo;

  Future<List<Task>> getRoots(int wsId) async => await taskRepo.getAll(wsId);
  Future<Iterable<Member>> getTaskMembers(int wsId, int taskId) async => await tmRoleRepo.getMembers(wsId, taskId);

  Future<Task?> save(Task t) async => await taskRepo.save(t);

  Future<Task> delete(Task t) async {
    if (t.id != null) {
      final deletedRows = await taskRepo.delete(t);
      // TODO: внутр. exception?
      if (deletedRows) {
        t.deleted = true;
      }
    }
    return t;
  }
}
