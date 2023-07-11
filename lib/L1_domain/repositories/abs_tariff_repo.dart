// Copyright (c) 2022. Alexandr Moroz

import '../entities/tariff.dart';
import '../entities/workspace.dart';

abstract class AbstractTariffRepo {
  Future<Iterable<Tariff>> getAll(Workspace ws);
}
