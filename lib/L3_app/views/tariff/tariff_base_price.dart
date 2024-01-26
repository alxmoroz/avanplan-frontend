// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L2_data/repositories/communications_repo.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/currency.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../extra/services.dart';

class TariffBasePrice extends StatelessWidget {
  const TariffBasePrice(this.tariff, {super.key});
  final Tariff tariff;

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      middle: MTCurrency(tariff.optionValue(TOCode.BASE_PRICE), color: mainColor),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SmallText(
            loc.tariff_option_base_price_title,
            align: TextAlign.center,
            maxLines: 1,
          ),
          const SizedBox(width: P2),
          SmallText(loc.details.toLowerCase(), color: mainColor, maxLines: 1),
          const LinkOutIcon(size: P3),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P2),
      bottomDivider: false,
      onTap: () => launchUrlString('$legalTariffsPath/${tariff.code.toLowerCase()}'),
    );
  }
}
