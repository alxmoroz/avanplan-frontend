// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/repositories/abs_source_repo.dart';
import '../../L1_domain/system/errors.dart';
import '../mappers/source.dart';
import '../services/api.dart';

class SourceRepo extends AbstractSourceRepo {
  o_api.IntegrationsSourcesApi get api => openAPI.getIntegrationsSourcesApi();

  @override
  Future<Iterable<Source>> getAll(int wsId) => throw UnimplementedError;

  @override
  Future<Source?> save(Source data) async {
    final wsId = data.wsId;
    final builder = o_api.SourceUpsertBuilder()
      ..id = data.id
      ..type = data.type
      ..url = data.url
      ..apiKey = data.apiKey
      ..username = data.username
      ..password = data.password
      ..description = data.description;

    final response = await api.upsertV1IntegrationsSourcesPost(sourceUpsert: builder.build(), wsId: wsId);
    return response.data?.source(wsId);
  }

  @override
  Future<bool> delete(Source data) async {
    final response = await api.deleteV1IntegrationsSourcesSourceIdDelete(sourceId: data.id!, wsId: data.wsId);
    return response.data == true;
  }

  @override
  Future<bool> checkConnection(Source s) async {
    bool res = false;
    try {
      final response = await api.checkConnectionV1IntegrationsSourcesCheckConnectionGet(sourceId: s.id!, wsId: s.wsId);
      res = response.data == true;
    } on DioError catch (e) {
      if (['ERR_IMPORT_CONNECTION'].contains(e.errCode)) {
        throw MTImportError();
      }
    }
    return res;
  }
}
