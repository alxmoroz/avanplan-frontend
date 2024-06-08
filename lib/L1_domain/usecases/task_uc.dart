// Copyright (c) 2024. Alexandr Moroz

import '../entities/task.dart';
import '../repositories/abs_task_repo.dart';

class TaskUC {
  TaskUC(this.repo);

  final AbstractTaskRepo repo;

  Future<TaskNode?> taskNode(int wsId, int taskId, {bool? closed}) async => await repo.taskNode(wsId, taskId, closed: closed);
  Future<TasksChanges?> save(Task t) async => await repo.save(t);
  Future<TasksChanges?> duplicate(Task t) async => await repo.duplicate(t);
  Future<TasksChanges?> move(Task src, Task destination) async => await repo.move(src, destination);
  Future<TasksChanges?> delete(Task t) async => await repo.delete(t);
  Future<bool> unlink(Task project) async => await repo.unlink(project);
}
