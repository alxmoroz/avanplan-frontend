// Copyright (c) 2022. Alexandr Moroz

import '../entities/remote_source.dart';
import '../entities/remote_source_type.dart';
import '../entities/task.dart';
import 'abs_api_repo.dart';

abstract class AbstractWSSourcesRepo extends AbstractApiRepo<RemoteSource, RemoteSource> {
  Future<bool> checkConnection(RemoteSource s);
  Future<bool> requestType(RemoteSourceType st, int wsId);

  Future<Iterable<RemoteProject>> getProjectsList(int wsId, int sourceId);
  Future<bool> import(int wsId, int sourceId, Iterable<RemoteProject> projects);
}
