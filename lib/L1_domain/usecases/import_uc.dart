// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../entities/task.dart';
import '../entities/task_source.dart';
import '../entities/workspace.dart';
import '../repositories/abs_import_repo.dart';

class ImportUC {
  ImportUC(this.repo);

  final AbstractImportRepo repo;

  Future<List<TaskRemote>> getRootTasks(Workspace ws, Source source) async => await repo.getRootTaskSources(ws, source);
  Future<bool> importTaskSources(Workspace ws, Source source, Iterable<TaskSourceImport> tss) async => await repo.importTaskSources(ws, source, tss);
  Future<bool> unlinkTaskSources(Workspace ws, int taskId, Iterable<TaskSource> tss) async => await repo.unlinkTaskSources(ws, taskId, tss);
}
