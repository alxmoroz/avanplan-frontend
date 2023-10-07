// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';
import '../repositories/abs_import_repo.dart';

class ImportUC {
  ImportUC(this.repo);

  final AbstractImportRepo repo;

  Future<Iterable<TaskRemote>> getProjectsList(int wsId, int sourceId) async => await repo.getProjectsList(wsId, sourceId);
  Future<bool> startImport(int wsId, int sourceId, Iterable<TaskRemote> projects) async => await repo.startImport(wsId, sourceId, projects);
  Future<bool> unlinkProject(Task project) async => await repo.unlinkProject(project);
}
