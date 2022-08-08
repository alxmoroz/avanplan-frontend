// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';
import '../entities/task_source.dart';

abstract class AbstractApiImportRepo {
  Future<List<TaskImport>> getRootTaskSources(int srcId);
  Future<bool> importTaskSources(int? srcId, Iterable<TaskSourceImport> tss);
}
