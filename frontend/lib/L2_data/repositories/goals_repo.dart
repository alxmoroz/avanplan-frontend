// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/goal.dart';
import '../../L1_domain/entities/goal_report.dart';
import '../../L1_domain/repositories/abstract_goals_repo.dart';
import '../../L3_app/extra/services.dart';

class GoalsRepo extends AbstractGoalsRepo {
  @override
  Future<List<Goal>> getGoals() async {
    final response = await openAPI.getGoalsApi().getGoalsApiV1GoalsGet();

    final List<Goal> goals = [];

    if (response.statusCode == 200) {
      final goalsData = response.data?.toList() ?? [];
      for (var g in goalsData) {
        final report = GoalReport(
          tasksCount: g.report?.tasksCount,
          closedTasksCount: g.report?.closedTasksCount,
          etaDate: g.report?.etaDate,
          factSpeed: g.report?.factSpeed,
          planSpeed: g.report?.planSpeed,
        );
        final goal = Goal(
          id: g.id,
          title: g.title,
          description: g.description,
          dueDate: g.dueDate,
          report: report,
        );
        goals.add(goal);
      }
    }
    return goals;
  }
}
