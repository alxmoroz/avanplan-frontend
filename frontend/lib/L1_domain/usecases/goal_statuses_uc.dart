// Copyright (c) 2022. Alexandr Moroz

import '../entities/goals/goal_status.dart';
import '../repositories/abstract_goal_statuses_repo.dart';

class GoalStatusesUC {
  GoalStatusesUC({required this.repo});

  final AbstractGoalStatusesRepo repo;

  Future<List<GoalStatus>> getGoalStatuses() async {
    return await repo.getGoalStatuses();
  }
}
