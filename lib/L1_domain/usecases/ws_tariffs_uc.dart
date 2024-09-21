// Copyright (c) 2022. Alexandr Moroz

import '../entities/invoice.dart';
import '../entities/tariff.dart';
import '../repositories/abs_ws_tariffs_repo.dart';

class WSTariffsUC {
  WSTariffsUC(this.repo);

  final AbstractWSTariffsRepo repo;

  Future<Invoice?> sign(int tariffId, int wsId) async => await repo.sign(tariffId, wsId);
  Future<Iterable<Tariff>> availableTariffs(int wsId) async => await repo.availableTariffs(wsId);
  Future<Invoice?> upsertOption(int wsId, int tariffId, int optionId, bool subscribe) async =>
      await repo.upsertOption(wsId, tariffId, optionId, subscribe);
}
