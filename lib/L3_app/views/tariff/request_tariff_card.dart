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
import '../../presenters/communications_presenter.dart';

class RequestTariffCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MTCard(
      elevation: cardElevation,
      child: Column(
        children: [
          const SizedBox(height: P),
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: P),
                H3(loc.tariff_type_request_title, align: TextAlign.center),
                const SizedBox(height: P2),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: const [StarIcon(), StarIcon(), StarIcon()]),
                const SizedBox(height: P_2),
                NormalText(loc.tariff_limit_special_conditions_title, align: TextAlign.center, padding: const EdgeInsets.all(P)),
              ],
            ),
          ),
          MediumText(loc.tariff_price_request_action_hint, align: TextAlign.center, color: greyColor, padding: const EdgeInsets.all(P)),
          MTButton.secondary(
            titleText: loc.tariff_price_request_action_title,
            margin: const EdgeInsets.all(P).copyWith(top: 0),
            onTap: () => sendMail(loc.tariff_price_request_mail_subject, appTitle, accountController.user?.id),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: P_2, vertical: P_2),
    );
  }
}
