// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/mt_currency.dart';
import '../../components/mt_list_tile.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';

class _TariffOptionTile extends StatelessWidget {
  const _TariffOptionTile({
    required this.tariff,
    required this.code,
  });

  final Tariff tariff;
  final String code;

  @override
  Widget build(BuildContext context) {
    final value = tariff.optionValue(code);
    final description = Intl.message('tariff_option_${code.toLowerCase()}_title');

    return MTListTile(
      middle: MTCurrency(value, f2Color),
      subtitle: LightText(description, align: TextAlign.center),
      padding: const EdgeInsets.symmetric(horizontal: P).copyWith(bottom: P_2),
      color: Colors.transparent,
      bottomDivider: false,
    );
  }
}

class TariffOptions extends StatelessWidget {
  const TariffOptions(this.tariff);
  final Tariff tariff;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (tariff.optionsMap.keys.isNotEmpty)
          for (var code in tariff.optionsMap.keys) _TariffOptionTile(tariff: tariff, code: code)
        else
          MediumText(
            loc.tariff_price_free_title,
            align: TextAlign.center,
            color: f2Color,
            padding: const EdgeInsets.all(P_2),
          ),
      ],
    );
  }
}
