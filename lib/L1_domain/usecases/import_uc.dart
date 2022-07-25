// Copyright (c) 2022. Alexandr Moroz

import '../entities/remote_tracker.dart';
import '../entities/task_import.dart';
import '../repositories/abs_import_repo.dart';

class ImportUC {
  ImportUC({required this.repo});

  final AbstractApiImportRepo repo;

  Future<List<TaskImport>> getRootTasks(int trackerId) async {
    return await repo.getRootTasks(trackerId);
  }

  Future<bool> importTasks(RemoteTracker tracker, List<String> rootTasksIds) async {
    return await repo.importTasks(tracker, rootTasksIds);
  }
}
