// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../components/constants.dart';
import '../../components/text_widgets.dart';
import '../../presenters/tariff_presenter.dart';
import 'tariff_limit_tile.dart';

class TariffCard extends StatelessWidget {
  const TariffCard(this.tariff);
  final Tariff tariff;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        H3(tariff.title, align: TextAlign.center),
        const SizedBox(height: P),
        for (final code in tariff.limitsMap.keys) TariffLimitTile(tariff: tariff, code: code),
      ],
    );
  }
}
