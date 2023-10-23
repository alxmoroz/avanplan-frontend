// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/source_type.dart';
import '../../L1_domain/repositories/abs_source_repo.dart';
import '../mappers/source.dart';
import '../services/api.dart';

class SourceRepo extends AbstractSourceRepo {
  IntegrationsSourcesApi get api => openAPI.getIntegrationsSourcesApi();

  @override
  Future<Source?> save(Source data) async {
    final builder = SourceUpsertBuilder()
      ..id = data.id
      ..type = data.typeCode
      ..url = data.url
      ..apiKey = data.apiKey
      ..username = data.username
      ..password = data.password
      ..description = data.description;

    final response = await api.sourcesUpsert(sourceUpsert: builder.build(), wsId: data.ws.id!);
    return response.data?.source(data.ws);
  }

  @override
  Future<Source?> delete(Source data) async {
    final response = await api.sourcesDelete(sourceId: data.id!, wsId: data.ws.id!);
    if (response.data == true) {
      return data;
    }
    return null;
  }

  @override
  Future<bool> checkConnection(Source s) async {
    try {
      final response = await api.sourcesCheckConnection(sourceId: s.id!, wsId: s.ws.id!);
      return response.data == true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> requestSourceType(SourceType st) async {
    final response = await api.requestSourceType(bodyRequestSourceType: (BodyRequestSourceTypeBuilder()..code = st.code).build());
    return response.data == true;
  }
}
