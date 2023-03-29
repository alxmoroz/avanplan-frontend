// Copyright (c) 2022. Alexandr Moroz

import '../entities/tariff.dart';
import '../repositories/abs_ws_repo.dart';

class TariffUC {
  TariffUC(this.repo);
  Future<TariffUC> init() async => this;

  final AbstractWSRepo<Tariff> repo;

  Future<Iterable<Tariff>> getAll(int wsId) async => await repo.getAll(wsId);
}
