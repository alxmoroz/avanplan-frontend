// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'tariff_option.dart';

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
  Iterable<TariffOption> get _options => optionsMap.values;

  TariffOption? option(String code) => optionsMap[code];

  num freeLimit(String code) => option(code)?.freeLimit ?? 0;
  num tariffQuantity(String code) => option(code)?.tariffQuantity ?? 1;
  num price(String code) => option(code)?.price ?? 0;

  bool get hasFeatures => _options.any((o) => o.userManageable);
  List<TariffOption> get features => _options.where((o) => o.userManageable).toList();
  List<TariffOption> get consumableOptions => _options.where((o) => o.price > 0 && !o.userManageable && o.code != TOCode.BASE_PRICE).toList();

  num get basePrice => price(TOCode.BASE_PRICE);

  static Tariff get dummy => Tariff(id: -1, code: '', tier: 0, hidden: false, optionsMap: {});
}
