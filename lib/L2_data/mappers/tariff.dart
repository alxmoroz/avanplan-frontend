// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/tariff.dart';

extension TariffMapper on api.TariffGet {
  Tariff get tariff => Tariff(
        id: id,
        code: code,
        tier: tier,
        limitsMap: {for (var tl in limits) tl.code: tl.value},
        optionsMap: {for (var to in options) to.code: to.price},
      );
}
