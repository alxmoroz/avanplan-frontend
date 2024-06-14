// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../components/button.dart';
import '../../components/card.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../presenters/tariff.dart';
import '../../usecases/ws_actions.dart';
import 'tariff_base_price.dart';
import 'tariff_options.dart';
import 'tariff_selector_controller.dart';

class TariffSelectorCard extends StatelessWidget {
  const TariffSelectorCard(this._tariff, this._controller, this._isCurrent, {super.key});

  final Tariff _tariff;
  final bool _isCurrent;
  final TariffSelectorController _controller;

  Widget _signButton(BuildContext context, Tariff tariff) => MTButton.main(
        titleText: loc.tariff_sign_action_title,
        margin: const EdgeInsets.symmetric(horizontal: P3),
        onTap: () => _controller.changeTariff(context, tariff),
      );

  @override
  Widget build(BuildContext context) {
    return MTCard(
      margin: const EdgeInsets.symmetric(horizontal: P2).copyWith(bottom: P),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          H2(_tariff.title, align: TextAlign.center, padding: const EdgeInsets.all(P3).copyWith(bottom: 0)),
          Expanded(child: TariffOptions(_tariff)),
          TariffBasePrice(_tariff),
          _isCurrent
              ? MTButton.main(
                  titleText: loc.tariff_current_title,
                  margin: const EdgeInsets.all(P3),
                )
              : _controller.ws.hpTariffUpdate
                  ? _signButton(context, _tariff)
                  : const MTButton.main(
                      middle: PrivacyIcon(color: f2Color),
                      margin: EdgeInsets.all(P3),
                    ),
        ],
      ),
    );
  }
}
