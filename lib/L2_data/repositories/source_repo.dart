// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/source_type.dart';
import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/repositories/abs_source_repo.dart';
import '../mappers/source.dart';
import '../services/api.dart';

class SourceRepo extends AbstractSourceRepo {
  IntegrationsSourcesApi get api => openAPI.getIntegrationsSourcesApi();

  @override
  Future<Iterable<Source>> getAll(Workspace ws) => throw UnimplementedError;

  @override
  Future<Source?> save(Workspace ws, Source data) async {
    final builder = SourceUpsertBuilder()
      ..id = data.id
      ..type = data.typeCode
      ..url = data.url
      ..apiKey = data.apiKey
      ..username = data.username
      ..password = data.password
      ..description = data.description;

    final response = await api.sourcesUpsert(sourceUpsert: builder.build(), wsId: ws.id!);
    return response.data?.source;
  }

  @override
  Future<bool> delete(Workspace ws, Source data) async {
    final response = await api.sourcesDelete(sourceId: data.id!, wsId: ws.id!);
    return response.data == true;
  }

  @override
  Future<bool> checkConnection(Workspace ws, Source s) async {
    final response = await api.sourcesCheckConnection(sourceId: s.id!, wsId: ws.id!);
    return response.data == true;
  }

  @override
  Future<bool> requestSourceType(SourceType st) async {
    final response = await api.requestSourceType(bodyRequestSourceType: (BodyRequestSourceTypeBuilder()..code = st.code).build());
    return response.data == true;
  }
}
