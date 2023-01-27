// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../repositories/abs_api_source_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class SourcesUC {
  SourcesUC({required this.repo});

  final AbstractApiSourceRepo repo;

  Future<bool> checkConnection(Source source) async => await repo.checkConnection(source);

  Future<List<Source>> getAll(int wsId) async => await repo.getAll(wsId);

  Future<Source?> save(Source source) async {
    Source? s;
    final username = source.username?.trim() ?? '';
    final apiKey = source.apiKey?.trim() ?? '';
    if (source.url.trim().isNotEmpty && (username.isNotEmpty || apiKey.isNotEmpty)) {
      s = await repo.save(source);
    }
    return s;
  }

  Future<Source?> delete(Source s) async {
    if (s.id != null) {
      final deletedRows = await repo.delete(s);
      if (deletedRows) {
        s.deleted = true;
      }
    }
    return s;
  }
}
