// Copyright (c) 2022. Alexandr Moroz

import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/goals/goal_import.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../../L3_app/extra/services.dart';
import '../mappers/goal_import.dart';

// TODO: для всех подобных репозиториев: развязать узел зависимости от 3 уровня за счёт инициализации openApi в конструктор репы

class ImportRepo extends AbstractApiImportRepo {
  IntegrationsGoalsApi get api => openAPI.getIntegrationsGoalsApi();

  @override
  Future<List<GoalImport>> getGoals(int trackerId) async {
    final response = await api.getGoalsApiV1IntegrationsGoalsGet(trackerId: trackerId);

    final List<GoalImport> goals = [];
    if (response.statusCode == 200) {
      for (GoalImportRemoteSchemaGet g in response.data?.toList() ?? []) {
        goals.add(g.goalImport);
      }
    }
    return goals;
  }

  @override
  Future<bool> importGoals(int trackerId, List<String> goalsIds) async {
    final response = await api.importGoalsApiV1IntegrationsGoalsImportPost(
      trackerId: trackerId,
      requestBody: BuiltList.from(goalsIds),
    );
    return response.statusCode == 200;
  }
}
