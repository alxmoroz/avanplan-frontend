// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../entities/task.dart';
import '../entities/task_source.dart';
import '../repositories/abs_api_import_repo.dart';

class ImportUC {
  ImportUC({required this.repo});

  final AbstractApiImportRepo repo;

  Future<List<TaskImport>> getRootTasks(Source source) async => await repo.getRootTaskSources(source);
  Future importTaskSources(Source source, Iterable<TaskSourceImport> tss) async => await repo.importTaskSources(source, tss);
  Future updateTaskSources(int wsId, Iterable<TaskSource> tss) async => await repo.updateTaskSources(wsId, tss);
}
