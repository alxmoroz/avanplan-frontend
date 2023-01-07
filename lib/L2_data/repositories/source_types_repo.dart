// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../mappers/source_type.dart';
import '../services/api.dart';

class SourceTypesRepo extends AbstractApiRepo<SourceType> {
  IntegrationsSourcesApi get api => openAPI.getIntegrationsSourcesApi();

  @override
  Future<List<SourceType>> getAll([dynamic query]) async {
    final response = await api.getSourceTypesV1IntegrationsSourcesTypesGet();

    final List<SourceType> types = [];
    if (response.statusCode == 200) {
      for (SourceTypeGet st in response.data?.toList() ?? []) {
        types.add(st.type);
      }
    }
    return types;
  }

  @override
  Future<SourceType?> save(dynamic data) => throw UnimplementedError();

  @override
  Future<bool> delete(int? id) => throw UnimplementedError();
}
