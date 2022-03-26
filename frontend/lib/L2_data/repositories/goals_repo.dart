// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/api_schema/goal.dart';
import '../../L1_domain/entities/goals/goal.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../../L3_app/extra/services.dart';
import '../mappers/goal.dart';

// TODO: для всех подобных репозиториев: развязать узел зависимости от 3 уровня за счёт инициализации openApi в конструктор репы

class GoalsRepo extends AbstractApiRepo<Goal, GoalUpsert> {
  GoalsApi get api => openAPI.getGoalsApi();

  @override
  Future<List<Goal>> getAll() async {
    final response = await api.getGoalsApiV1GoalsGet();

    final List<Goal> goals = [];
    if (response.statusCode == 200) {
      for (GoalSchemaGet g in response.data?.toList() ?? []) {
        goals.add(g.goal);
      }
    }
    return goals;
  }

  @override
  Future<Goal?> save(GoalUpsert data) async {
    //TODO: не учитываются возможные ошибки! Нет обработки 403 и т.п.
    final builder = GoalSchemaUpsertBuilder()
      ..id = data.id
      ..statusId = data.statusId
      ..title = data.title
      ..description = data.description
      ..closed = data.closed
      ..dueDate = data.dueDate?.toUtc();

    final response = await api.upsertGoalApiV1GoalsPost(goalSchemaUpsert: builder.build());
    Goal? goal;
    if (response.statusCode == 201) {
      goal = response.data?.goal;
    }
    return goal;
  }

  @override
  Future<bool> delete(int id) async {
    final response = await api.deleteGoalApiV1GoalsGoalIdDelete(goalId: id);
    return response.statusCode == 200 && response.data?.asNum == 1;
  }
}
