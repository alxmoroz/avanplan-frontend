// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../mappers/source.dart';
// TODO: нарушение направления зависимостей. аналогично в похожих местах
import 'api.dart';

class SourcesRepo extends AbstractApiRepo<Source> {
  o_api.IntegrationsSourcesApi get api => openAPI.getIntegrationsSourcesApi();

  @override
  Future<List<Source>> getAll([dynamic query]) async => throw UnimplementedError();

  @override
  Future<Source?> save(Source data) async {
    final builder = o_api.SourceUpsertBuilder()
      ..id = data.id
      ..sourceTypeId = data.type.id
      ..url = data.url
      ..apiKey = data.apiKey
      ..login = data.login
      ..password = data.password
      ..description = data.description
      ..workspaceId = data.workspaceId;

    final response = await api.upsertSourceV1IntegrationsSourcesPost(sourceUpsert: builder.build());
    Source? source;
    if (response.statusCode == 201) {
      source = response.data?.source;
    }
    return source;
  }

  @override
  Future<bool> delete(int id) async {
    final response = await api.deleteSourceV1IntegrationsSourcesSourceIdDelete(sourceId: id);
    return response.statusCode == 200 && response.data?.asNum == 1;
  }
}
