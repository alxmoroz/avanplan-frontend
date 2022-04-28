// Copyright (c) 2022. Alexandr Moroz

import '../entities/goals/goal_import.dart';
import '../entities/goals/remote_tracker.dart';
import '../repositories/abs_api_repo.dart';

class ImportUC {
  ImportUC({required this.repo});

  final AbstractApiImportRepo repo;

  Future<List<GoalImport>> getGoals(int trackerId) async {
    return await repo.getGoals(trackerId);
  }

  Future<bool> importGoals(RemoteTracker tracker, List<String> goalsIds) async {
    return await repo.importGoals(tracker, goalsIds);
  }
}
