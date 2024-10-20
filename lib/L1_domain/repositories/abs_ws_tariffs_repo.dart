// Copyright (c) 2022. Alexandr Moroz

import '../entities/invoice.dart';
import '../entities/tariff.dart';

abstract class AbstractWSTariffsRepo {
  Future<Iterable<Tariff>> availableTariffs(int wsId);
  Future<Invoice?> sign(int tariffId, int wsId);
  Future<Invoice?> upsertOption(int wsId, int tariffId, int optionId, bool subscribe);
}
