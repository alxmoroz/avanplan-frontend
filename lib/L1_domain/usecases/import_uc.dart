// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../entities/task.dart';
import '../entities/workspace.dart';
import '../repositories/abs_import_repo.dart';

class ImportUC {
  ImportUC(this.repo);

  final AbstractImportRepo repo;

  Future<Iterable<TaskRemote>> getProjectsList(Workspace ws, Source source) async => await repo.getProjectsList(ws, source);
  Future<bool> startImport(Workspace ws, Source source, Iterable<TaskRemote> projects) async => await repo.startImport(ws, source, projects);
  Future<bool> unlinkProject(Task project) async => await repo.unlinkProject(project);
}
