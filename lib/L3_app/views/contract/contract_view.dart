// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import '../../presenters/ws_presenter.dart';
import '../tariff/tariff_info.dart';
import '../tariff/tariff_select_view.dart';

class ContractView extends StatelessWidget {
  static String get routeName => '/contract';

  Workspace get ws => mainController.selectedWS!;

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
      bottomBar: MTButton.outlined(
        titleText: loc.tariff_change_action_title,
        onTap: () => changeTariff(ws),
        margin: const EdgeInsets.symmetric(horizontal: P),
      ),
    );
  }
}
