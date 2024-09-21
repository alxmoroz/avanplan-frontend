// Copyright (c) 2022. Alexandr Moroz

import '../entities/remote_source.dart';
import '../entities/remote_source_type.dart';
import '../entities/task.dart';
import '../repositories/abs_ws_sources_repo.dart';

class RemoteSourcesUC {
  RemoteSourcesUC(this.repo);

  final AbstractWSSourcesRepo repo;

  Future<bool> checkConnection(RemoteSource source) async => await repo.checkConnection(source);
  Future<bool> requestType(RemoteSourceType st, int wsId) async => await repo.requestType(st, wsId);

  Future<RemoteSource?> save(RemoteSource source) async => await repo.save(source);

  Future<RemoteSource?> delete(RemoteSource s) async {
    if (s.id != null) {
      if (await repo.delete(s) != null) {
        s.removed = true;
      }
    }
    return s;
  }

  Future<Iterable<RemoteProject>> getProjectsList(int wsId, int sourceId) async => await repo.getProjectsList(wsId, sourceId);
  Future<bool> startImport(int wsId, int sourceId, Iterable<RemoteProject> projects) async => await repo.import(wsId, sourceId, projects);
}
