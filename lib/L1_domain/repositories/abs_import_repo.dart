// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../entities/task.dart';
import '../entities/task_source.dart';

abstract class AbstractApiImportRepo {
  Future<List<TaskImport>> getRootTasks(int srcId);
  Future<bool> importTasks(Source src, Iterable<TaskSourceImport> tss);
}
