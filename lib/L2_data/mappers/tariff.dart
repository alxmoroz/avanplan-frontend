// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/tariff.dart';

extension TariffMapper on api.TariffGet {
  Tariff get tariff => Tariff(
        id: id,
        code: code,
        tier: tier,
        estimateChargePerBillingPeriod: estimateChargePerBillingPeriod ?? 0,
        limitsMap: {for (var tl in limits.sortedBy<num>((lm) => lm.id)) tl.code: tl.value},
        optionsMap: {for (var to in options.sortedBy<num>((opt) => opt.id)) to.code: to.price},
      );
}
