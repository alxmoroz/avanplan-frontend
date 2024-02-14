// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/tariff.dart';

extension TariffOptionMapper on api.TariffOptionGet {
  TariffOption get tariffOption => TariffOption(
        id: id,
        code: code,
        price: price ?? 0,
        billingQuantity: tariffQuantity ?? 1,
        freeLimit: freeLimit ?? 0,
      );
}

extension TariffMapper on api.TariffGet {
  Tariff get tariff => Tariff(
        id: id,
        code: code,
        tier: tier,
        hidden: hidden,
        estimateChargePerBillingPeriod: estimateChargePerBillingPeriod ?? 0,
        optionsMap: {for (var to in options.sortedBy<num>((opt) => opt.id)) to.code: to.tariffOption},
      );
}
