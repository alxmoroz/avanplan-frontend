// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/goals/goal.dart';
import '../../L1_domain/repositories/abstract_goals_repo.dart';
import '../../L3_app/extra/services.dart';
import '../mappers/goal.dart';

class GoalsRepo extends AbstractGoalsRepo {
  @override
  Future<List<Goal>> getGoals() async {
    final response = await openAPI.getGoalsApi().getGoalsApiV1GoalsGet();

    final List<Goal> goals = [];
    if (response.statusCode == 200) {
      for (GoalSchemaGet g in response.data?.toList() ?? []) {
        goals.add(g.goal);
      }
    }
    return goals;
  }

  @override
  Future<Goal?> saveGoal({required String title, required String description, required DateTime dueDate}) async {
    //TODO: не учитываются возможные ошибки! Нет обработки 403 и т.п.

    final builder = GoalSchemaUpsertBuilder()
      ..title = title
      ..description = description
      ..dueDate = dueDate;

    final response = await openAPI.getGoalsApi().upsertGoalApiV1GoalsPost(goalSchemaUpsert: builder.build());
    Goal? goal;
    if (response.statusCode == 201) {
      goal = response.data?.goal;
    }
    return goal;
  }
}
