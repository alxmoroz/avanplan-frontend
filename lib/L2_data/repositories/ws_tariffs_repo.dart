// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as o_api;

import '../../L1_domain/entities/invoice.dart';
import '../../L1_domain/entities/tariff.dart';
import '../../L1_domain/repositories/abs_ws_tariffs_repo.dart';
import '../mappers/invoice.dart';
import '../mappers/tariff.dart';
import '../services/api.dart';

class WSTariffsRepo extends AbstractWSTariffsRepo {
  o_api.WSTariffsApi get _api => avanplanApi.getWSTariffsApi();

  @override
  Future<Iterable<Tariff>> availableTariffs(int wsId) async {
    final response = await _api.availableTariffs(wsId: wsId);
    return response.data?.map((t) => t.tariff) ?? [];
  }

  @override
  Future<Invoice?> sign(int tariffId, int wsId) async {
    final response = await _api.sign(tariffId: tariffId, wsId: wsId);
    return response.data?.invoice;
  }

  @override
  Future<Invoice?> upsertOption(int wsId, int tariffId, int optionId, bool subscribe) async {
    final response = await _api.upsertOption(wsId: wsId, tariffId: tariffId, optionId: optionId, subscribe: subscribe);
    return response.data?.invoice;
  }
}
