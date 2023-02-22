// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/tariff.dart';

extension LimitMapper on api.LimitGet {
  Limit get limit => Limit(id: id, code: code);
}

extension LimitTariffMapper on api.LimitTariffGet {
  LimitTariff get limitTariff => LimitTariff(
        id: id,
        limit: limit.limit,
        value: value,
      );
}

extension TariffCodeMapper on api.TariffGet {
  Tariff get tariff => Tariff(
        id: id,
        code: code,
        priceMonthUser: priceMonthUser,
        limits: limits.map((limit) => limit.limitTariff),
      );
}

extension WSTariffMapper on api.WSTariffGet {
  WSTariff get wsTariff => WSTariff(
        id: id,
        tariff: tariff.tariff,
        expiresOn: expiresOn?.toLocal(),
      );
}
