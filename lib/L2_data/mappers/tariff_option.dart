// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as api;

import '../../L1_domain/entities/tariff_option.dart';
import 'promo_action.dart';

extension TariffOptionMapper on api.TariffOptionGet {
  TariffOption get tariffOption => TariffOption(
        id: id,
        code: code,
        price: price ?? 0,
        tariffQuantity: tariffQuantity ?? 1,
        freeLimit: freeLimit ?? 0,
        userManageable: userManageable ?? false,
        promoAction: promoAction?.promoAction,
      );
}
