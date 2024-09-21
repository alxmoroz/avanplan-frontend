// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../entities/source_type.dart';
import '../entities/task.dart';
import '../repositories/abs_ws_sources_repo.dart';

class WSSourcesUC {
  WSSourcesUC(this.repo);

  final AbstractWSSourcesRepo repo;

  Future<bool> checkConnection(Source source) async => await repo.checkConnection(source);
  Future<bool> requestType(SourceType st, int wsId) async => await repo.requestType(st, wsId);

  Future<Source?> save(Source source) async => await repo.save(source);

  Future<Source?> delete(Source s) async {
    if (s.id != null) {
      if (await repo.delete(s) != null) {
        s.removed = true;
      }
    }
    return s;
  }

  Future<Iterable<ProjectRemote>> getProjectsList(int wsId, int sourceId) async => await repo.getProjectsList(wsId, sourceId);
  Future<bool> startImport(int wsId, int sourceId, Iterable<ProjectRemote> projects) async => await repo.import(wsId, sourceId, projects);
}
