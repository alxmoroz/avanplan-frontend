// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/tariff.dart';
import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/repositories/abs_tariff_repo.dart';
import '../mappers/tariff.dart';
import '../services/api.dart';

class TariffRepo extends AbstractTariffRepo {
  o_api.TariffsApi get api => openAPI.getTariffsApi();

  @override
  Future<Iterable<Tariff>> getAll(Workspace ws) async {
    final response = await api.tariffsV1RefsTariffsGet(wsId: ws.id!);
    return response.data?.map((t) => t.tariff) ?? [];
  }
}
