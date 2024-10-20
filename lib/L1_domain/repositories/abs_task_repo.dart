// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';
import 'abs_api_repo.dart';

abstract class AbstractTaskRepo extends AbstractApiRepo<TasksChanges, Task> {
  Future<Iterable<Task>> tasksList(int wsId, Iterable<int> taskIds);
  Future<TaskNode?> taskNode(int wsId, int taskId, {bool? closed, bool? fullTree});
  Future<TasksChanges?> move(Task src, Task destination);
  Future<TasksChanges?> repeat(Task src);
  Future<bool> unlink(Task project);
}
