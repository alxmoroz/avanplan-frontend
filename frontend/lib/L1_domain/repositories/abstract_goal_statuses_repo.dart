// Copyright (c) 2022. Alexandr Moroz

import '../entities/goals/goal_status.dart';

abstract class AbstractGoalStatusesRepo {
  Future<List<GoalStatus>> getGoalStatuses();
}
