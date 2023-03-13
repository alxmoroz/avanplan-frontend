// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../components/constants.dart';
import '../../components/text_widgets.dart';
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
        H3(tariff.title, align: TextAlign.center),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: P),
              for (var code in tariff.limitsMap.keys) TariffLimitTile(tariff: tariff, code: code),
            ],
          ),
        ),
        for (var code in tariff.optionsMap.keys) TariffOptionTile(tariff: tariff, code: code),
        const SizedBox(height: P),
      ],
    );
  }
}
