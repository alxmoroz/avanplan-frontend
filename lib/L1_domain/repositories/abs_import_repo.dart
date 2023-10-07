// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../entities/task.dart';
import '../entities/workspace.dart';

abstract class AbstractImportRepo {
  Future<Iterable<TaskRemote>> getProjectsList(Workspace ws, Source source);
  Future<bool> startImport(Workspace ws, Source source, Iterable<TaskRemote> projects);
  Future<bool> unlinkProject(Task project);
}
