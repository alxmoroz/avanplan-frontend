// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/currency.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../extra/services.dart';

class TariffBasePrice extends StatelessWidget {
  const TariffBasePrice(this._tariff, {super.key});
  final Tariff _tariff;

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      middle: MTPrice(_tariff.basePrice, color: mainColor),
      subtitle: BaseText.f2(loc.tariff_option_base_price_suffix, align: TextAlign.center, maxLines: 1),
      padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P2),
      bottomDivider: false,
    );
  }
}
