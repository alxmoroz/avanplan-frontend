// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/goals/goal.dart';
import '../../L1_domain/entities/goals/goal_report.dart';
import '../../L1_domain/entities/goals/task.dart';
import '../../L1_domain/entities/goals/task_status.dart';
import '../../L1_domain/repositories/abstract_goals_repo.dart';
import '../../L3_app/extra/services.dart';

class GoalsRepo extends AbstractGoalsRepo {
  @override
  Future<List<Goal>> getGoals() async {
    final response = await openAPI.getGoalsApi().getGoalsApiV1GoalsGet();

    final List<Goal> goals = [];

    if (response.statusCode == 200) {
      for (GoalSchemaGet g in response.data?.toList() ?? []) {
        final report = GoalReport(
          etaDate: g.report?.etaDate,
          factSpeed: g.report?.factSpeed ?? 0,
          planSpeed: g.report?.planSpeed ?? 0,
        );

        goals.add(Goal(
          id: g.id,
          createdOn: g.createdOn,
          updatedOn: g.updatedOn,
          title: g.title,
          description: g.description ?? '',
          dueDate: g.dueDate,
          report: report,
          tasks: g.tasks?.map(
                (t) => Task(
                  id: t.id,
                  createdOn: t.createdOn,
                  updatedOn: t.updatedOn,
                  title: t.title,
                  description: t.description ?? '',
                  dueDate: t.dueDate,
                  status: t.status != null
                      ? TaskStatus(
                          id: t.status!.id,
                          title: t.status!.title,
                          closed: t.status!.closed,
                        )
                      : null,
                ),
              ) ??
              [],
        ));
      }
    }
    return goals;
  }
}
