// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class TOCode {
  static const BASE_PRICE = 'BASE_PRICE';
  static const USERS_COUNT = 'USERS_COUNT';
  static const TASKS_COUNT = 'TASKS_COUNT';
  static const FS_VOLUME = 'FS_VOLUME';
}

class Tariff extends Codable {
  Tariff({
    required super.id,
    required super.code,
    required this.tier,
    required this.estimateChargePerBillingPeriod,
    required this.limitsMap,
    required this.optionsMap,
  });

  final int tier;
  final num estimateChargePerBillingPeriod;
  final Map<String, num> limitsMap;
  final Map<String, num> optionsMap;

  num limitValue(String code) => limitsMap[code] ?? 0;
  num optionValue(String code) => optionsMap[code] ?? 0;

  bool passLimit(String code, num value) => value <= limitValue(code);

  static Tariff get dummy => Tariff(id: -1, code: '', tier: 0, estimateChargePerBillingPeriod: 0, limitsMap: {}, optionsMap: {});
}
