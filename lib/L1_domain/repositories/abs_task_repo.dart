// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';
import 'abs_api_repo.dart';

abstract class AbstractTaskRepo extends AbstractApiRepo<TasksChanges, Task> {
  Future<TaskNode?> taskNode(int wsId, int taskId) => throw UnimplementedError();
  Future<TasksChanges?> move(Task src, Task destination) => throw UnimplementedError();
}
