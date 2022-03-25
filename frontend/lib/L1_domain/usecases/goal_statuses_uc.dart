// Copyright (c) 2022. Alexandr Moroz

import '../../../L1_domain/repositories/abstract_goal_statuses_repo.dart';
import '../entities/goals/goal_status.dart';

class GoalStatusesUC {
  GoalStatusesUC({required this.repo});

  final AbstractGoalStatusesRepo repo;

  Future<List<GoalStatus>> getGoalStatuses() async {
    return await repo.getGoalStatuses();
  }
}
