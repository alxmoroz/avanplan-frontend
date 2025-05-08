// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../components/button.dart';
import '../../components/card.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../theme/text.dart';
import '../../usecases/communications.dart';
import '../app/services.dart';

class RequestTariffCard extends StatelessWidget {
  const RequestTariffCard({super.key});

  @override
  Widget build(BuildContext context) {
    final smallHeight = MediaQuery.sizeOf(context).height < SCR_XS_HEIGHT;
    return MTCard(
      margin: const EdgeInsets.symmetric(horizontal: P2).copyWith(bottom: P),
      child: Column(
        children: [
          H2(loc.tariff_type_request_title, align: TextAlign.center, padding: const EdgeInsets.all(P3).copyWith(bottom: 0)),
          if (smallHeight)
            const Spacer()
          else
            for (var n in [1, 2, 3, 4])
              MTListTile(
                leading: const StarIcon(),
                middle: BaseText(Intl.message('tariff_special_conditions_title$n'), maxLines: 2),
                padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P4),
                bottomDivider: false,
              ),
          const Spacer(),
          BaseText.f2(
            loc.tariff_special_request_action_hint,
            align: TextAlign.center,
            maxLines: 2,
            padding: const EdgeInsets.all(P2).copyWith(bottom: 0),
          ),
          MTButton.main(
            titleText: loc.tariff_special_request_action_title,
            margin: const EdgeInsets.all(P3),
            onTap: () => mailUs(subject: loc.tariff_special_request_mail_subject),
          ),
        ],
      ),
    );
  }
}
