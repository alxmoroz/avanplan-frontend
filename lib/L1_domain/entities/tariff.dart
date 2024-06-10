// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class TOCode {
  static const BASE_PRICE = 'BASE_PRICE';
  static const USERS_COUNT = 'USERS_COUNT';
  static const TASKS_COUNT = 'TASKS_COUNT';
  static const FS_VOLUME = 'FS_VOLUME';

  static const FEATURE_SET_TEAM = 'FEATURE_SET_TEAM';
  static const FEATURE_SET_ANALYTICS = 'FEATURE_SET_ANALYTICS';
}

class TariffOption extends Codable {
  TariffOption({
    required super.id,
    required super.code,
    required this.price,
    required this.billingQuantity,
    required this.freeLimit,
    required this.userManageable,
  });

  final num price;
  final num billingQuantity;
  final num freeLimit;
  final bool userManageable;
}

class Tariff extends Codable {
  Tariff({
    required super.id,
    required super.code,
    required this.tier,
    required this.hidden,
    required this.optionsMap,
  });

  final int tier;
  final bool hidden;
  final Map<String, TariffOption> optionsMap;

  num price(String code) => optionsMap[code]?.price ?? 0;
  num freeLimit(String code) => optionsMap[code]?.freeLimit ?? 0;
  num billingQuantity(String code) => optionsMap[code]?.billingQuantity ?? 1;
  bool get hasManageableOptions => optionsMap.values.any((o) => o.userManageable);

  bool hasOption(String code) => optionsMap.containsKey(code);

  num get basePrice => price(TOCode.BASE_PRICE);

  static Tariff get dummy => Tariff(id: -1, code: '', tier: 0, hidden: false, optionsMap: {});
}
