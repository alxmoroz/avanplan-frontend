// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../components/constants.dart';
import '../../components/list_tile.dart';
import '../../components/price.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import '../app/services.dart';

class TariffBasePrice extends StatelessWidget {
  const TariffBasePrice(this._tariff, {super.key});
  final Tariff _tariff;

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      color: b3Color,
      middle: MTPrice(_tariff.basePrice, color: mainColor),
      subtitle: BaseText.f2(loc.per_month_suffix, align: TextAlign.center, maxLines: 1),
      padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P2),
    );
  }
}
