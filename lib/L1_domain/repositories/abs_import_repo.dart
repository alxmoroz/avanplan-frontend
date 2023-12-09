// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';

abstract class AbstractImportRepo {
  Future<Iterable<TaskRemote>> getProjectsList(int wsId, int sourceId);
  Future<bool> import(int wsId, int sourceId, Iterable<TaskRemote> projects);
  Future<bool> unlinkProject(Task project);
}
