// Copyright (c) 2022. Alexandr Moroz

import '../api_schema/base_upsert.dart';
import '../entities/base_entity.dart';
import '../entities/remote_tracker.dart';
import '../entities/task_import.dart';

abstract class AbstractApiRepo<E extends RPersistable, U extends BaseUpsert, Q extends BaseSchema> {
  Future<List<E>> getAll([Q? query]);
  Future<E?> save(U data);
  Future<bool> delete(int id);
}

abstract class AbstractApiImportRepo {
  Future<List<TaskImport>> getRootTasks(int trackerId);
  Future<bool> importTasks(RemoteTracker tracker, List<String> rootTasksIds);
}
