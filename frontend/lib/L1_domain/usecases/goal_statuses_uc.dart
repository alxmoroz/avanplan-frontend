// Copyright (c) 2022. Alexandr Moroz

import '../entities/goals/goal_status.dart';
import '../repositories/abs_api_repo.dart';

class GoalStatusesUC {
  GoalStatusesUC({required this.repo});

  final AbstractApiRepo<GoalStatus> repo;

  Future<List<GoalStatus>> getStatuses() async {
    return await repo.getAll();
  }
}
