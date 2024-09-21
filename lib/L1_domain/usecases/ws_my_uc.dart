// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';
import '../repositories/abs_ws_my_repo.dart';

class WSMyUC {
  WSMyUC(this.repo);

  final AbstractWSMyRepo repo;

  Future<Iterable<Task>> myProjects(int wsId, {bool? imported, bool? closed}) async => await repo.myProjects(
        wsId,
        imported: imported,
        closed: closed,
      );
  Future<Iterable<Task>> myTasks(int wsId, {int? projectId}) async => await repo.myTasks(wsId, projectId: projectId);
}
