// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../entities/source_type.dart';
import '../entities/workspace.dart';
import '../repositories/abs_source_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class SourceUC {
  SourceUC(this.repo);

  final AbstractSourceRepo repo;

  Future<bool> checkConnection(Workspace ws, Source source) async => await repo.checkConnection(ws, source);
  Future<bool> requestSourceType(SourceType st) async => await repo.requestSourceType(st);

  Future<Source?> save(Workspace ws, Source source) async {
    Source? s;
    final username = source.username?.trim() ?? '';
    final apiKey = source.apiKey?.trim() ?? '';
    if (source.url.trim().isNotEmpty && (username.isNotEmpty || apiKey.isNotEmpty)) {
      s = await repo.save(ws, source);
    }
    return s;
  }

  Future<Source?> delete(Workspace ws, Source s) async {
    if (s.id != null) {
      final deletedRows = await repo.delete(ws, s);
      if (deletedRows) {
        s.deleted = true;
      }
    }
    return s;
  }
}
