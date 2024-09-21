// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../entities/source_type.dart';
import '../entities/task.dart';
import 'abs_api_repo.dart';

abstract class AbstractWSSourcesRepo extends AbstractApiRepo<Source, Source> {
  Future<bool> checkConnection(Source s) async => throw UnimplementedError();
  Future<bool> requestType(SourceType st, int wsId) async => throw UnimplementedError();

  Future<Iterable<ProjectRemote>> getProjectsList(int wsId, int sourceId) async => throw UnimplementedError();
  Future<bool> import(int wsId, int sourceId, Iterable<ProjectRemote> projects) async => throw UnimplementedError();
}
