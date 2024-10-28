// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';
import '../entities/task_relation.dart';
import '../repositories/abs_ws_relations_repo.dart';

class WSRelationsUC {
  WSRelationsUC(this.repo);

  final AbstractWSRelationsRepo repo;

  Future<Iterable<Task>> sourcesForRelations(int wsId) async => await repo.sourcesForRelations(wsId);
  Future<TaskRelation?> upsertRelation(TaskRelation relation) async => await repo.save(relation);
  Future<TaskRelation?> deleteRelation(TaskRelation relation) async => await repo.delete(relation);
}
