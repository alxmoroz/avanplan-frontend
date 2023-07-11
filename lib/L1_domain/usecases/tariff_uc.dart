// Copyright (c) 2022. Alexandr Moroz

import '../entities/tariff.dart';
import '../entities/workspace.dart';
import '../repositories/abs_tariff_repo.dart';

class TariffUC {
  TariffUC(this.repo);

  final AbstractTariffRepo repo;

  Future<Iterable<Tariff>> getAll(Workspace ws) async => await repo.getAll(ws);
}
