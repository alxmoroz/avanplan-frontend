// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/api_schema/goal_upsert.dart';
import '../../L1_domain/entities/element_of_work.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../../L3_app/extra/services.dart';
import '../mappers/goal.dart';

// TODO: для всех подобных репозиториев: развязать узел зависимости от 3 уровня за счёт инициализации openApi в конструктор репы

class GoalsRepo extends AbstractApiRepo<ElementOfWork, GoalUpsert> {
  GoalsApi get api => openAPI.getGoalsApi();

  @override
  Future<List<ElementOfWork>> getAll() async => throw UnimplementedError();

  @override
  Future<ElementOfWork?> save(GoalUpsert data) async {
    // TODO: не учитываются возможные ошибки! Нет обработки 403 и т.п.
    final builder = GoalSchemaUpsertBuilder()
      ..id = data.id
      ..title = data.title
      ..description = data.description
      ..closed = data.closed
      ..dueDate = data.dueDate?.toUtc()
      ..workspaceId = data.workspaceId;

    final response = await api.upsertGoalV1GoalsPost(goalSchemaUpsert: builder.build());
    ElementOfWork? goal;
    if (response.statusCode == 201) {
      goal = response.data?.goal;
    }
    return goal;
  }

  @override
  Future<bool> delete(int id) async {
    final response = await api.deleteGoalV1GoalsGoalIdDelete(goalId: id);
    return response.statusCode == 200 && response.data?.asNum == 1;
  }
}
