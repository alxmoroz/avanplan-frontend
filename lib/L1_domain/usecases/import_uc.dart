// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../entities/task.dart';
import '../entities/task_source.dart';
import '../repositories/abs_import_repo.dart';

class ImportUC {
  ImportUC({required this.repo});

  final AbstractApiImportRepo repo;

  Future<List<TaskImport>> getRootTasks(int srcId) async {
    return await repo.getRootTasks(srcId);
  }

  Future<bool> importTasks(Source src, Iterable<TaskSourceImport> tss) async {
    return await repo.importTasks(src, tss);
  }
}
