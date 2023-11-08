// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/tariff.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../mappers/tariff.dart';
import '../services/api.dart';

class TariffRepo extends AbstractApiRepo<Tariff, Tariff> {
  o_api.TariffsApi get api => openAPI.getTariffsApi();

  @override
  Future<Iterable<Tariff>> getAllWithWS(int wsId) async {
    final response = await api.getAvailableTariffs(wsId: wsId);
    return response.data?.map((t) => t.tariff) ?? [];
  }
}
