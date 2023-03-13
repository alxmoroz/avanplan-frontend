// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan/L3_app/components/colors.dart';
import 'package:avanplan/L3_app/components/mt_money.dart';
import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
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

    String description = '';

    if (code == 'TO_USERS_COUNT') {
      description = code;
    }

    return MTListTile(middle: MTCurrency(value, greyColor), subtitle: LightText(description), bottomBorder: false);
  }
}
