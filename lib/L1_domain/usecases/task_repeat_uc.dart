// Copyright (c) 2022. Alexandr Moroz

import '../entities/task_repeat.dart';
import '../repositories/abs_api_repo.dart';

class TaskRepeatUC {
  TaskRepeatUC(this.repo);

  final AbstractApiRepo<TaskRepeat, TaskRepeat> repo;

  Future<TaskRepeat?> save(TaskRepeat tr) async => await repo.save(tr);
  Future<TaskRepeat?> delete(TaskRepeat tr) async => await repo.delete(tr);
}
