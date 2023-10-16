// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/currency.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../extra/services.dart';

class _TariffOptionTile extends StatelessWidget {
  const _TariffOptionTile({
    this.value,
    this.description,
  });

  final num? value;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      middle: value != null ? MTCurrency(value!, color: mainColor) : null,
      subtitle: description != null ? SmallText(description!, align: TextAlign.center, padding: const EdgeInsets.symmetric(vertical: P)) : null,
      padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(bottom: P),
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
          for (var code in tariff.optionsMap.keys)
            _TariffOptionTile(
              value: tariff.optionValue(code),
              description: Intl.message('tariff_option_${code.toLowerCase()}_title'),
            )
        else
          _TariffOptionTile(description: loc.tariff_price_free_title)
      ],
    );
  }
}
