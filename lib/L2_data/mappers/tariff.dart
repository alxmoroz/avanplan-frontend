// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/tariff.dart';

extension LimitTariffMapper on api.TariffLimitGet {
  TariffLimit get limitTariff => TariffLimit(
        id: id,
        code: code,
        value: value,
      );
}

extension TariffCodeMapper on api.TariffGet {
  Tariff get tariff => Tariff(
        id: id,
        code: code,
        price: price,
        limits: limits.map((limit) => limit.limitTariff),
      );
}
