// Copyright (c) 2022. Alexandr Moroz

import '../entities/goals/goal_import.dart';
import '../repositories/abs_api_repo.dart';

class ImportUC {
  ImportUC({required this.repo});

  final AbstractApiImportRepo repo;

  Future<List<GoalImport>> getGoals(int trackerId) async {
    return await repo.getGoals(trackerId);
  }

  Future<bool> importGoals(int trackerId, int workspaceId, List<String> goalsIds) async {
    return await repo.importGoals(trackerId, workspaceId, goalsIds);
  }
}
