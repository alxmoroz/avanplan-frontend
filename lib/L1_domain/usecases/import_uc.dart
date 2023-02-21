// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../entities/task.dart';
import '../entities/task_source.dart';
import '../repositories/abs_import_repo.dart';

class ImportUC {
  ImportUC({required this.repo});

  final AbstractImportRepo repo;

  Future<List<TaskRemote>> getRootTasks(Source source) async => await repo.getRootTaskSources(source);
  Future<bool> importTaskSources(Source source, Iterable<TaskSourceImport> tss) async => await repo.importTaskSources(source, tss);
  Future<bool> unlinkTaskSources(int wsId, Iterable<TaskSource> tss) async => await repo.unlinkTaskSources(wsId, tss);
}
