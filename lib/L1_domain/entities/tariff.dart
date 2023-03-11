// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Tariff extends Codable {
  Tariff({
    required super.id,
    required super.code,
    required this.limitsMap,
  });

  final Map<String, num> limitsMap;

  num limitValue(String code) => limitsMap[code] ?? 0;
}
