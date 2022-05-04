// Copyright (c) 2022. Alexandr Moroz

import '../api_schema/base_upsert.dart';
import '../entities/base_entity.dart';
import '../entities/goals/goal_import.dart';
import '../entities/goals/remote_tracker.dart';

abstract class AbstractApiRepo<E extends RPersistable, U extends BaseUpsert> {
  Future<List<E>> getAll();
  Future<E?> save(U data);
  Future<bool> delete(int id);
}

abstract class AbstractApiImportRepo {
  Future<List<GoalImport>> getGoals(int trackerId);
  Future<bool> importGoals(RemoteTracker tracker, List<String> goalsIds);
}
