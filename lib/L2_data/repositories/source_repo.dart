// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/source_type.dart';
import '../../L1_domain/repositories/abs_source_repo.dart';
import '../mappers/source.dart';
import '../services/api.dart';

class SourceRepo extends AbstractSourceRepo {
  SourcesApi get api => openAPI.getSourcesApi();

  @override
  Future<Source?> save(Source data) async {
    final b = SourceUpsertBuilder()
      ..id = data.id
      ..type = data.typeCode
      ..url = data.url
      ..apiKey = data.apiKey
      ..username = data.username
      ..password = data.password
      ..description = data.description;

    final response = await api.upsertSource(
      wsId: data.wsId,
      sourceUpsert: b.build(),
    );
    return response.data?.source(data.wsId);
  }

  @override
  Future<Source?> delete(Source data) async {
    final response = await api.deleteSource(sourceId: data.id!, wsId: data.wsId);
    return response.data == true ? data : null;
  }

  @override
  Future<bool> checkConnection(Source s) async {
    try {
      final response = await api.checkConnection(sourceId: s.id!, wsId: s.wsId);
      return response.data == true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> requestType(SourceType st, int wsId) async {
    final response = await api.requestType(bodyRequestType: (BodyRequestTypeBuilder()..code = st.code).build(), wsId: wsId);
    return response.data == true;
  }
}
