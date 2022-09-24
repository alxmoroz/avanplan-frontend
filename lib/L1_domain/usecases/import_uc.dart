// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';
import '../entities/task_source.dart';
import '../repositories/abs_import_repo.dart';

class ImportUC {
  ImportUC({required this.repo});

  final AbstractApiImportRepo repo;

  // TODO(san-smith): не уверен, что здесь есть смысл в async/await.
  Future<List<TaskImport>> getRootTasks(int srcId) async => await repo.getRootTaskSources(srcId);

  Future<bool> importTaskSources(int? srcId, Iterable<TaskSourceImport> tss) async => await repo.importTaskSources(srcId, tss);
  Future<bool> updateTaskSources(Iterable<TaskSource> tss) async => await repo.updateTaskSources(tss);
}
