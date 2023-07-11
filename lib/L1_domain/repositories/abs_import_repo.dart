// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../entities/task.dart';
import '../entities/task_source.dart';
import '../entities/workspace.dart';

abstract class AbstractImportRepo {
  Future<List<TaskRemote>> getRootTaskSources(Workspace ws, Source source);
  Future<bool> importTaskSources(Workspace ws, Source source, Iterable<TaskSourceImport> tss);
  Future<bool> unlinkTaskSources(Workspace ws, int taskId, Iterable<TaskSource> tss);
}
