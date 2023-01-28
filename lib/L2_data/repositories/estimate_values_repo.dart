// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/estimate_value.dart';
import '../../L1_domain/repositories/abs_api_ws_repo.dart';
import '../mappers/estimate_value.dart';
import '../services/api.dart';

class EstimateValueRepo extends AbstractApiWSRepo<EstimateValue> {
  SettingsApi get api => openAPI.getSettingsApi();

  @override
  Future<List<EstimateValue>> getAll(int wsId) async {
    final List<EstimateValue> eValues = [];
    final response = await api.getEstimateValuesV1SettingsEstimateValuesGet(wsId: wsId);
    if (response.statusCode == 200) {
      for (EstimateValueGet ev in response.data?.toList() ?? []) {
        eValues.add(ev.estimateValue(wsId));
      }
    }
    return eValues;
  }

  @override
  Future<EstimateValue?> save(EstimateValue data) => throw UnimplementedError();

  @override
  Future<bool> delete(EstimateValue data) => throw UnimplementedError();
}
