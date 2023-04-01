// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L2_data/repositories/communications_repo.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_card.dart';
import '../../components/mt_list_tile.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/communications_presenter.dart';

class RequestTariffCard extends StatelessWidget {
  Widget _tile(String titleText) => MTListTile(leading: const StarIcon(), titleText: titleText, bottomBorder: false);

  @override
  Widget build(BuildContext context) {
    return MTCard(
      elevation: 3,
      child: Column(
        children: [
          const SizedBox(height: P),
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: P),
                H3(loc.tariff_type_request_title, align: TextAlign.center),
                const SizedBox(height: P),
                _tile(loc.tariff_limit_no_limits_title),
                _tile(loc.tariff_limit_special_conditions_title),
                _tile(loc.tariff_limit_in_house_deployment_title),
                _tile(loc.tariff_limit_staff_training_title),
              ],
            ),
          ),
          H4(loc.tariff_price_request_action_title, align: TextAlign.center, color: greyColor, padding: const EdgeInsets.all(P)),
          MTButton.outlined(
            titleColor: greenColor,
            titleText: loc.contact_us_title,
            margin: const EdgeInsets.all(P).copyWith(top: 0),
            onTap: () => sendMail(loc.tariff_price_request_mail_subject, appTitle, accountController.user?.id),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: P_2, vertical: P_2),
    );
  }
}
