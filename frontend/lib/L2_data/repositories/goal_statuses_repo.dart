// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/goals/goal_status.dart';
import '../../L1_domain/repositories/abstract_goal_statuses_repo.dart';
import '../../L3_app/extra/services.dart';
import '../mappers/goal_status.dart';

class GoalStatusesRepo extends AbstractGoalStatusesRepo {
  GoalsApi get api => openAPI.getGoalsApi();

  @override
  Future<List<GoalStatus>> getGoalStatuses() async {
    final response = await api.getGoalsStatusesApiV1GoalsStatusesGet();

    final List<GoalStatus> statuses = [];
    if (response.statusCode == 200) {
      for (GoalStatusSchemaGet gs in response.data?.toList() ?? []) {
        statuses.add(gs.status);
      }
    }
    return statuses;
  }
}
