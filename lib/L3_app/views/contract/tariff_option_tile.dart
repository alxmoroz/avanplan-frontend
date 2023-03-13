// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../components/colors.dart';
import '../../components/mt_currency.dart';
import '../../components/mt_list_tile.dart';
import '../../components/text_widgets.dart';

class TariffOptionTile extends StatelessWidget {
  const TariffOptionTile({
    super.key,
    required this.tariff,
    required this.code,
  });

  final Tariff tariff;
  final String code;

  @override
  Widget build(BuildContext context) {
    final value = tariff.optionValue(code);

    final description = Intl.message('tariff_option_${code.toLowerCase()}_title');

    return MTListTile(middle: MTCurrency(value, greyColor), subtitle: LightText(description, align: TextAlign.center), bottomBorder: false);
  }
}
