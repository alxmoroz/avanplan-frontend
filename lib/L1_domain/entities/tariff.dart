// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import 'base_entity.dart';

class TOCode {
  static const BASE_PRICE = 'BASE_PRICE';
  static const TASKS = 'TASKS';
  static const FILE_STORAGE = 'FILE_STORAGE';
  static const TEAM = 'TEAM';
  static const ANALYTICS = 'ANALYTICS';
  static const GOALS = 'GOALS';
  static const TASKBOARD = 'TASKBOARD';
}

class TariffOption extends Codable {
  TariffOption({
    required super.id,
    required super.code,
    required this.price,
    required this.billingQuantity,
    required this.freeLimit,
    required this.userManageable,
    required this.projectRelated,
  });

  final num price;
  final num billingQuantity;
  final num freeLimit;
  final bool userManageable;
  final bool projectRelated;

  String get title => Intl.message('tariff_option_${code.toLowerCase()}_title');
  String get subtitle => Intl.message('tariff_option_${code.toLowerCase()}_subtitle');
  String get description => Intl.message('tariff_option_${code.toLowerCase()}_description');
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
  List<TariffOption> get manageableOptions => optionsMap.values.where((o) => o.userManageable).toList();
  List<TariffOption> get pricedOptions => optionsMap.values.where((o) => o.price > 0 && !o.userManageable).toList();

  bool hasOption(String code) => optionsMap.containsKey(code);

  num get basePrice => price(TOCode.BASE_PRICE);

  static Tariff get dummy => Tariff(id: -1, code: '', tier: 0, hidden: false, optionsMap: {});
}
