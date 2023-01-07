// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/repositories/abs_api_source_repo.dart';
import '../../L1_domain/system/errors.dart';
import '../mappers/source.dart';
import '../services/api.dart';

class SourcesRepo extends AbstractApiSourceRepo {
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
      ..username = data.username
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

  @override
  Future<bool> checkConnection(int id) async {
    bool res = false;
    try {
      final response = await api.checkConnectionV1IntegrationsSourcesCheckConnectionGet(sourceId: id);
      res = response.statusCode == 200 && response.data == true;
    } on DioError catch (e) {
      if (['ERR_IMPORT_CONNECTION'].contains(e.errCode)) {
        throw MTImportError();
      }
    }
    return res;
  }
}
