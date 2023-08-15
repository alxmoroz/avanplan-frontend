// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import '../../presenters/ws_presenter.dart';
import '../../usecases/ws_available_actions.dart';
import '../../usecases/ws_tariff.dart';
import 'tariff_limits.dart';
import 'tariff_options.dart';

class ActiveContractView extends StatelessWidget {
  const ActiveContractView(this.ws);

  final Workspace ws;
  static String get routeName => '/active_contract';

  Tariff get tariff => ws.invoice.tariff;

  @override
  Widget build(BuildContext context) {
    return MTPage(
      navBar: navBar(
        context,
        middle: ws.subPageTitle(loc.tariff_current_title),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: TariffLimits(tariff),
      ),
      bottomBar: ws.hpTariffUpdate
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TariffOptions(tariff),
                MTButton.main(
                  titleText: loc.tariff_change_action_title,
                  onTap: () => ws.changeTariff(),
                )
              ],
            )
          : null,
    );
  }
}
