// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import '../../presenters/ws_presenter.dart';
import '../../usecases/ws_ext_actions.dart';
import '../tariff/tariff_info.dart';
import '../tariff/tariff_select_view.dart';

class ContractView extends StatelessWidget {
  const ContractView(this.ws);

  final Workspace ws;
  static String get routeName => '/contract';

  @override
  Widget build(BuildContext context) {
    return MTPage(
      navBar: navBar(
        context,
        middle: ws.subPageTitle(loc.tariff_current_title),
        bgColor: backgroundColor,
      ),
      body: SafeArea(
        child: TariffInfo(ws.invoice.tariff),
      ),
      bottomBar: ws.hpTariffUpdate
          ? MTButton.outlined(
              titleText: loc.tariff_change_action_title,
              onTap: () => changeTariff(ws),
            )
          : null,
    );
  }
}
