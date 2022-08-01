// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../entities/task_import.dart';
import '../repositories/abs_import_repo.dart';

class ImportUC {
  ImportUC({required this.repo});

  final AbstractApiImportRepo repo;

  Future<List<TaskImport>> getRootTasks(int srcId) async {
    return await repo.getRootTasks(srcId);
  }

  Future<bool> importTasks(Source src, List<String> codes) async {
    return await repo.importTasks(src, codes);
  }
}
