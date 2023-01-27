// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../entities/task.dart';
import '../entities/task_source.dart';

abstract class AbstractApiImportRepo {
  Future<List<TaskImport>> getRootTaskSources(Source source);
  Future importTaskSources(Source source, Iterable<TaskSourceImport> tss);
  Future updateTaskSources(int wsId, Iterable<TaskSource> tss);
}
