// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/api_schema/base_upsert_schema.dart';
import '../../L1_domain/entities/goals/goal_status.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../../L3_app/extra/services.dart';
import '../mappers/goal_status.dart';

class GoalStatusesRepo extends AbstractApiRepo<GoalStatus, BaseUpsert> {
  GoalsApi get api => openAPI.getGoalsApi();

  @override
  Future<List<GoalStatus>> getAll() async {
    final response = await api.getGoalsStatusesV1GoalsStatusesGet();

    final List<GoalStatus> statuses = [];
    if (response.statusCode == 200) {
      for (GoalStatusSchemaGet gs in response.data?.toList() ?? []) {
        statuses.add(gs.status);
      }
    }
    return statuses;
  }

  @override
  Future<GoalStatus?> save(dynamic data) {
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) {
    throw UnimplementedError();
  }
}
