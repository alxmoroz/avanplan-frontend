// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';

abstract class AbstractImportRepo {
  Future<Iterable<ProjectRemote>> getProjectsList(int wsId, int sourceId) async => throw UnimplementedError();
  Future<bool> import(int wsId, int sourceId, Iterable<ProjectRemote> projects) async => throw UnimplementedError();
}
