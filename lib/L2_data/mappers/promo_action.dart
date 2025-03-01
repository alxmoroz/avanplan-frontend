// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as api;

import '../../L1_domain/entities/promo_action.dart';

extension PromoActionMapper on api.PromoActionGet {
  PromoAction get promoAction => PromoAction(
        id: id,
        code: code,
        discount: discount,
        durationDays: durationDays,
      );
}
