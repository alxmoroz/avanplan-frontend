// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/tariff.dart';
import 'tariff_option.dart';

extension TariffMapper on api.TariffGet {
  Tariff get tariff => Tariff(
        id: id,
        code: code,
        tier: tier,
        hidden: hidden,
        optionsMap: {for (var to in options.sortedBy<num>((opt) => opt.id)) to.code: to.tariffOption},
      );
}
