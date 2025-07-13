// Copyright (c) 2023. Alexandr Moroz

import 'package:avanplan/L3_app/presenters/date.dart';
import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/ws_tariff.dart';
import '../../components/adaptive.dart';
import '../../components/constants.dart';
import '../../components/list_tile.dart';
import '../../components/price.dart';
import '../../presenters/tariff_option.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import 'tariff_option.dart';

class TariffOptions extends StatelessWidget {
  const TariffOptions(this._ws, this._tariff, {super.key});
  // NB! Тариф и РП совпадают в частном случае только. Поэтому отдельные аргументы
  final Workspace _ws;
  final Tariff _tariff;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        // тарифицируемые опции
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) => TariffOptionTile(_tariff.consumableOptions[index]),
          itemCount: _tariff.consumableOptions.length,
        ),
        // функции
        // TODO: сделать по аналогии с затратами - единый стиль с опциями
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            final f = _tariff.features[index];
            final actualPrice = _ws.finalPrice(f.code) ?? f.finalPrice;
            final endDate = _ws.consumedEndDate(f.code);
            final term = endDate != null ? endDate.priceDurationSuffix : f.priceDurationSuffix;

            return MTListTile(
              color: b3Color,
              leading: f.icon(),
              middle: BaseText(f.title, align: TextAlign.left),
              subtitle: Row(
                children: [
                  MTPrice(actualPrice, color: f2Color, size: AdaptiveSize.xs),
                  DSmallText(' $term', color: f2Color, align: TextAlign.left),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P4),
            );
          },
          itemCount: _tariff.features.length,
        ),
      ],
    );
  }
}
