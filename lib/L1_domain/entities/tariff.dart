// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class TLCode {
  static const USERS_COUNT = 'USERS_COUNT';
  static const PROJECTS_UNLINK_ALLOWED = 'PROJECTS_UNLINK_ALLOWED';
  static const PROJECTS_COUNT = 'PROJECTS_COUNT';
  static const TASKS_COUNT = 'TASKS_COUNT';
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

  bool passLimit(String code, int value) => value <= limitValue(code);
}
