// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/appbar.dart';
import '../../components/button.dart';
import '../../components/page.dart';
import '../../extra/services.dart';
import '../../presenters/workspace.dart';
import '../../usecases/ws_actions.dart';
import '../../usecases/ws_tariff.dart';
import 'tariff_limits.dart';
import 'tariff_options.dart';

class ActiveContractView extends StatelessWidget {
  const ActiveContractView(this._ws);
  final Workspace _ws;

  static String get routeName => '/active_contract';
  static String title(Workspace ws) => '$ws - ${loc.tariff_current_title}';

  Tariff get tariff => _ws.invoice.tariff;

  @override
  Widget build(BuildContext context) {
    return MTPage(
      appBar: MTAppBar(context, middle: _ws.subPageTitle(loc.tariff_current_title)),
      body: SafeArea(
        top: false,
        bottom: false,
        child: TariffLimits(tariff),
      ),
      bottomBar: _ws.hpTariffUpdate
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TariffOptions(tariff),
                MTButton.main(
                  titleText: loc.tariff_change_action_title,
                  onTap: () => _ws.changeTariff(),
                )
              ],
            )
          : null,
    );
  }
}
