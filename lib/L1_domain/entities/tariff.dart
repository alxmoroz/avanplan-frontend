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
    required this.limits,
  });

  final Iterable<TariffLimit> limits;
}
