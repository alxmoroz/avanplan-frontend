// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../repositories/abs_api_repo.dart';
import '../repositories/abs_api_source_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class SourcesUC {
  SourcesUC({required this.repo});

  final AbstractApiSourceRepo repo;

  Future<bool> checkConnection(int id) async => await repo.checkConnection(id);

  Future<Source?> save(Source data) async {
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
    // TODO: внутр. exception
    if (s.id != null) {
      final deletedRows = await repo.delete(s.id!);
      if (deletedRows) {
        s.deleted = true;
      }
    }
    return s;
  }
}

class SourceTypesUC {
  SourceTypesUC({required this.repo});

  final AbstractApiRepo<SourceType> repo;

  Future<List<SourceType>> getAll() async => await repo.getAll();
}
