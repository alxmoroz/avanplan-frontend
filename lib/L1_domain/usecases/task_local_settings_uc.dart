// Copyright (c) 2022. Alexandr Moroz

import '../entities/task_local_settings.dart';
import '../repositories/abs_db_repo.dart';

class TasksLocalSettingsUC {
  TasksLocalSettingsUC(this.repo);

  final AbstractDBRepo<AbstractDBModel, TaskLocalSettings> repo;

  Future<Iterable<TaskLocalSettings>> getAll() async => await repo.getAll();
  Future update(TaskLocalSettings data) async => await repo.update((ts) => ts.wsId == data.wsId && ts.taskId == data.taskId, data);
}
