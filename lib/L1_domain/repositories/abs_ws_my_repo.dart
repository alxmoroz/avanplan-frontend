// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';

abstract class AbstractWSMyRepo {
  Future<Iterable<Task>> myProjects(int wsId, {bool? closed, bool? imported});
  Future<Iterable<Task>> myTasks(int wsId, {int? projectId});
}
