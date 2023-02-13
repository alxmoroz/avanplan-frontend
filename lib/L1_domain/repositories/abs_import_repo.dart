// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../entities/task.dart';
import '../entities/task_source.dart';

abstract class AbstractImportRepo {
  Future<List<TaskRemote>> getRootTaskSources(Source source);
  Future<bool> importTaskSources(Source source, Iterable<TaskSourceImport> tss);
  Future<bool> updateTaskSources(int wsId, Iterable<TaskSource> tss);
}
