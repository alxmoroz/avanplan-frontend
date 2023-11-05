// Copyright (c) 2022. Alexandr Moroz

import '../entities/tariff.dart';
import '../repositories/abs_api_repo.dart';

class TariffUC {
  TariffUC(this.repo);

  final AbstractApiRepo<Tariff, Tariff> repo;

  Future<Iterable<Tariff>> getAll(int wsId) async => await repo.getAllWithWS(wsId);
}
