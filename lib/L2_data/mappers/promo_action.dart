// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/promo_action.dart';

extension PromoActionMapper on api.PromoActionGet {
  PromoAction get promoAction => PromoAction(
        id: id,
        code: code,
        discount: discount,
        durationDays: durationDays,
      );
}
