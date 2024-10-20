// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';
import '../repositories/abs_task_repo.dart';

class TaskUC {
  TaskUC(this.repo);

  final AbstractTaskRepo repo;

  Future<Iterable<Task>> tasksList(int wsId, Iterable<int> taskIds) async => await repo.tasksList(wsId, taskIds);

  Future<TaskNode?> taskNode(int wsId, int taskId, {bool? closed, bool? fullTree}) async =>
      await repo.taskNode(wsId, taskId, closed: closed, fullTree: fullTree);

  Future<TasksChanges?> save(Task t) async => await repo.save(t);
  Future<TasksChanges?> repeat(Task t) async => await repo.repeat(t);
  Future<TasksChanges?> duplicate(Task t) async => await repo.duplicate(t);
  Future<TasksChanges?> move(Task src, Task destination) async => await repo.move(src, destination);
  Future<TasksChanges?> delete(Task t) async => await repo.delete(t);
  Future<bool> unlink(Task project) async => await repo.unlink(project);
}
