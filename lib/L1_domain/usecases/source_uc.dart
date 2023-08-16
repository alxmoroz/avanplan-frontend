// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../entities/source_type.dart';
import '../repositories/abs_source_repo.dart';

class SourceUC {
  SourceUC(this.repo);

  final AbstractSourceRepo repo;

  Future<bool> checkConnection(Source source) async => await repo.checkConnection(source);
  Future<bool> requestSourceType(SourceType st) async => await repo.requestSourceType(st);

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
      if (await repo.delete(s) != null) {
        s.removed = true;
      }
    }
    return s;
  }
}
