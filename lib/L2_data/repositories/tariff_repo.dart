// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/tariff.dart';
import '../../L1_domain/repositories/abs_ws_repo.dart';
import '../mappers/tariff.dart';
import '../services/api.dart';

class TariffRepo extends AbstractWSRepo<Tariff> {
  o_api.TariffsApi get api => openAPI.getTariffsApi();

  @override
  Future<Iterable<Tariff>> getAll(int wsId) async {
    final response = await api.tariffsV1TariffsGet(wsId: wsId);
    return response.data?.map((t) => t.tariff) ?? [];
  }

  @override
  Future<Tariff?> save(Tariff data) => throw UnimplementedError();
  @override
  Future<bool> delete(Tariff data) => throw UnimplementedError();
}
