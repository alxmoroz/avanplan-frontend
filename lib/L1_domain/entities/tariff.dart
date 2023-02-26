// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class TariffLimit extends Codable {
  TariffLimit({
    required super.id,
    required super.code,
    required this.value,
  });

  final int value;
}

class Tariff extends Codable {
  Tariff({
    required super.id,
    required super.code,
    required this.priceMonthUser,
    required this.limits,
  });

  final int priceMonthUser;
  final Iterable<TariffLimit> limits;
}

class WSTariff extends RPersistable {
  WSTariff({
    required super.id,
    required this.tariff,
    this.expiresOn,
  });

  final Tariff tariff;
  final DateTime? expiresOn;
}
