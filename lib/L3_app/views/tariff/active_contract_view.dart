// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
  const ActiveContractView(this._wsId);
  final int _wsId;

  static String get routeName => '/active_contract';
  static String title(int _wsId) => '${mainController.wsForId(_wsId)} - ${loc.tariff_current_title}';

  Workspace get ws => mainController.wsForId(_wsId);
  Tariff get tariff => ws.invoice.tariff;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        appBar: MTAppBar(context, middle: ws.subPageTitle(loc.tariff_current_title)),
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
      ),
    );
  }
}
