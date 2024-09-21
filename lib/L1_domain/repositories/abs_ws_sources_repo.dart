// Copyright (c) 2022. Alexandr Moroz

import '../entities/remote_source.dart';
import '../entities/remote_source_type.dart';
import '../entities/task.dart';
import 'abs_api_repo.dart';

abstract class AbstractWSSourcesRepo extends AbstractApiRepo<RemoteSource, RemoteSource> {
  Future<bool> checkConnection(RemoteSource s) async => throw UnimplementedError();
  Future<bool> requestType(RemoteSourceType st, int wsId) async => throw UnimplementedError();

  Future<Iterable<RemoteProject>> getProjectsList(int wsId, int sourceId) async => throw UnimplementedError();
  Future<bool> import(int wsId, int sourceId, Iterable<RemoteProject> projects) async => throw UnimplementedError();
}
