// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Limit extends Codable {
  Limit({required super.id, required super.code});
}

class LimitTariff extends RPersistable {
  LimitTariff({
    required super.id,
    required this.limit,
    required this.value,
  });

  final Limit limit;
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
  final Iterable<LimitTariff> limits;
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
