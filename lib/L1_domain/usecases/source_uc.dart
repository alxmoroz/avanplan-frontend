// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../repositories/abs_source_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class SourceUC {
  SourceUC(this.repo);

  final AbstractSourceRepo repo;

  Future<bool> checkConnection(Source source) async => await repo.checkConnection(source);

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
