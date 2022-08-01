// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../entities/task_import.dart';

abstract class AbstractApiImportRepo {
  Future<List<TaskImport>> getRootTasks(int srcId);
  Future<bool> importTasks(Source src, List<String> codes);
}
