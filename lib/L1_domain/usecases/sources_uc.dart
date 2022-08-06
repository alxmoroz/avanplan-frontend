// Copyright (c) 2022. Alexandr Moroz

import '../api_schema/source_upsert.dart';
import '../entities/source.dart';
import '../repositories/abs_api_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class SourcesUC {
  SourcesUC({required this.repo});

  final AbstractApiRepo<Source, SourceUpsert> repo;

  Future<Source?> save(SourceUpsert data) async {
    Source? s;
    // TODO: внутр. exception - валидация...
    final login = data.login?.trim() ?? '';
    final apiKey = data.apiKey?.trim() ?? '';
    if (data.url.trim().isNotEmpty && (login.isNotEmpty || apiKey.isNotEmpty)) {
      s = await repo.save(data);
    }
    return s;
  }

  Future<Source?> delete({required Source s}) async {
    final deletedRows = await repo.delete(s.id);
    // TODO: внутр. exception
    if (deletedRows) {
      s.deleted = true;
    }
    return s;
  }
}

class SourceTypesUC {
  SourceTypesUC({required this.repo});

  final AbstractApiRepo<SourceType, dynamic> repo;

  Future<List<SourceType>> getAll() async => await repo.getAll();
}
