// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class TOCode {
  static const BASE_PRICE = 'BASE_PRICE';
  static const USERS_COUNT = 'USERS_COUNT';
  static const TASKS_COUNT = 'TASKS_COUNT';
  static const FS_VOLUME = 'FS_VOLUME';
}

class TariffOption extends Codable {
  TariffOption({
    required super.id,
    required super.code,
    required this.price,
    required this.billingQuantity,
    required this.freeLimit,
  });

  final num price;
  final num billingQuantity;
  final num freeLimit;
}

class Tariff extends Codable {
  Tariff({
    required super.id,
    required super.code,
    required this.tier,
    required this.hidden,
    required this.estimateChargePerBillingPeriod,
    required this.optionsMap,
  });

  final int tier;
  final bool hidden;
  final num estimateChargePerBillingPeriod;
  final Map<String, TariffOption> optionsMap;

  num price(String code) => optionsMap[code]?.price ?? 0;
  num freeLimit(String code) => optionsMap[code]?.freeLimit ?? 0;
  num billingQuantity(String code) => optionsMap[code]?.billingQuantity ?? 1;

  num get basePrice => price(TOCode.BASE_PRICE);

  static Tariff get dummy => Tariff(id: -1, code: '', tier: 0, hidden: false, estimateChargePerBillingPeriod: 0, optionsMap: {});
}
