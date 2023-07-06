// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/source_type.dart';
import '../../L1_domain/repositories/abs_source_repo.dart';
import '../../L1_domain/system/errors.dart';
import '../mappers/source.dart';
import '../services/api.dart';

class SourceRepo extends AbstractSourceRepo {
  IntegrationsSourcesApi get api => openAPI.getIntegrationsSourcesApi();

  @override
  Future<Iterable<Source>> getAll(int wsId) => throw UnimplementedError;

  @override
  Future<Source?> save(Source data) async {
    final wsId = data.wsId;
    final builder = SourceUpsertBuilder()
      ..id = data.id
      ..type = data.typeCode
      ..url = data.url
      ..apiKey = data.apiKey
      ..username = data.username
      ..password = data.password
      ..description = data.description;

    final response = await api.sourcesUpsert(sourceUpsert: builder.build(), wsId: wsId);
    return response.data?.source(wsId);
  }

  @override
  Future<bool> delete(Source data) async {
    final response = await api.sourcesDelete(sourceId: data.id!, wsId: data.wsId);
    return response.data == true;
  }

  @override
  Future<bool> checkConnection(Source s) async {
    bool res = false;
    try {
      final response = await api.sourcesCheckConnection(sourceId: s.id!, wsId: s.wsId);
      res = response.data == true;
    } on DioException catch (e) {
      if (['ERR_IMPORT_CONNECTION'].contains(e.errCode)) {
        throw MTImportError();
      }
    }
    return res;
  }

  @override
  Future<bool> requestSourceType(SourceType st) async {
    final response = await api.requestSourceType(bodyRequestSourceType: (BodyRequestSourceTypeBuilder()..code = st.code).build());
    return response.data == true;
  }
}
