// Copyright (c) 2022. Alexandr Moroz

import '../entities/remote_tracker.dart';
import '../entities/task_import.dart';

abstract class AbstractApiImportRepo {
  Future<List<TaskImport>> getRootTasks(int trackerId);
  Future<bool> importTasks(RemoteTracker tracker, List<String> rootTasksIds);
}
