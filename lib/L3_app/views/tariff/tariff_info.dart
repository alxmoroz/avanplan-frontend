// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/tariff_presenter.dart';
import 'tariff_limit_tile.dart';
import 'tariff_option_tile.dart';

class TariffInfo extends StatelessWidget {
  const TariffInfo(this.tariff);
  final Tariff tariff;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: P),
              H3(tariff.title, align: TextAlign.center),
              const SizedBox(height: P),
              for (var code in tariff.limitsMap.keys) TariffLimitTile(tariff: tariff, code: code),
            ],
          ),
        ),
        if (tariff.optionsMap.keys.isNotEmpty)
          for (var code in tariff.optionsMap.keys) TariffOptionTile(tariff: tariff, code: code)
        else
          H4(loc.tariff_price_free_title, align: TextAlign.center, color: greyColor, padding: const EdgeInsets.all(P)),
      ],
    );
  }
}
