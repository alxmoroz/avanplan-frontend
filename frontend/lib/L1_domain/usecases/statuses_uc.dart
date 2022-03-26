// Copyright (c) 2022. Alexandr Moroz

import '../entities/base_entity.dart';
import '../entities/goals/goal_status.dart';
import '../entities/goals/task_status.dart';
import '../repositories/abs_api_repo.dart';

abstract class StatusesUC<S extends Statusable> {
  StatusesUC({required this.repo});

  final AbstractApiRepo<S, dynamic> repo;

  Future<List<S>> getStatuses() async {
    return await repo.getAll();
  }
}

class GoalStatusesUC extends StatusesUC<GoalStatus> {
  GoalStatusesUC({required AbstractApiRepo<GoalStatus, dynamic> repo}) : super(repo: repo);
}

class TaskStatusesUC extends StatusesUC<TaskStatus> {
  TaskStatusesUC({required AbstractApiRepo<TaskStatus, dynamic> repo}) : super(repo: repo);
}
