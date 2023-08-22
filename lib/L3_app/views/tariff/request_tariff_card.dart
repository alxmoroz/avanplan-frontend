// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L2_data/repositories/communications_repo.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_card.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/communications.dart';

class RequestTariffCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MTCard(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                H3(loc.tariff_type_request_title, align: TextAlign.center, padding: const EdgeInsets.all(P)),
                const Row(mainAxisAlignment: MainAxisAlignment.center, children: [StarIcon(), StarIcon(), StarIcon()]),
                const SizedBox(height: P_2),
                NormalText(loc.tariff_limit_special_conditions_title, align: TextAlign.center, padding: const EdgeInsets.all(P)),
              ],
            ),
          ),
          MediumText(
            loc.tariff_price_request_action_hint,
            align: TextAlign.center,
            color: fgL2Color,
            padding: const EdgeInsets.all(P_2),
          ),
          MTButton.secondary(
            titleText: loc.tariff_price_request_action_title,
            margin: const EdgeInsets.symmetric(horizontal: P),
            onTap: () => sendMail(loc.tariff_price_request_mail_subject, appTitle, accountController.user?.id),
          ),
          const SizedBox(height: P2),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: P_2).copyWith(bottom: P_2),
    );
  }
}
