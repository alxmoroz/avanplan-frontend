// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/estimate_value.dart';
import '../../L1_domain/repositories/abs_ws_repo.dart';
import '../mappers/estimate_value.dart';
import '../services/api.dart';

class EstimateValueRepo extends AbstractWSRepo<EstimateValue> {
  SettingsApi get api => openAPI.getSettingsApi();

  @override
  Future<Iterable<EstimateValue>> getAll(int wsId) async {
    final response = await api.getEstimateValuesV1SettingsEstimateValuesGet(wsId: wsId);
    return response.data?.map((ev) => ev.estimateValue(wsId)) ?? [];
  }

  @override
  Future<EstimateValue?> save(EstimateValue data) => throw UnimplementedError();

  @override
  Future<bool> delete(EstimateValue data) => throw UnimplementedError();
}
