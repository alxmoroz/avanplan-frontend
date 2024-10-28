// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';
import '../entities/task_relation.dart';
import 'abs_api_repo.dart';

abstract class AbstractWSRelationsRepo extends AbstractApiRepo<TaskRelation, TaskRelation> {
  Future<Iterable<Task>> sourcesForRelations(int wsId);
}
