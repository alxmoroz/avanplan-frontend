// Copyright (c) 2022. Alexandr Moroz

import '../entities/invoice.dart';
import '../entities/tariff.dart';
import '../repositories/abs_tariff_repo.dart';

class TariffUC {
  TariffUC(this.repo);

  final AbstractTariffRepo repo;

  Future<Invoice?> sign(int tariffId, int wsId) async => await repo.sign(tariffId, wsId);
  Future<Iterable<Tariff>> availableTariffs(int wsId) async => await repo.availableTariffs(wsId);
  Future<Invoice?> upsertOption(int wsId, int tariffId, int optionId, bool subscribe) async =>
      await repo.upsertOption(wsId, tariffId, optionId, subscribe);
}
