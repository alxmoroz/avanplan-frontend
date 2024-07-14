// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';
import '../entities/task_transaction.dart';
import '../repositories/abs_api_repo.dart';

class TaskTransactionUC {
  TaskTransactionUC(this.repo);

  final AbstractApiRepo<TasksChanges, TaskTransaction> repo;

  Future<TasksChanges?> save(TaskTransaction tr) async => await repo.save(tr);
  Future<TasksChanges?> delete(TaskTransaction tr) async => await repo.delete(tr);
}
