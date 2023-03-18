// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import '../tariff/tariff_info.dart';
import '../tariff/tariff_select_view.dart';

class ContractView extends StatelessWidget {
  static String get routeName => '/contract';

  Workspace get ws => mainController.selectedWS!;

  Future _changeTariff(BuildContext context) async {
    loaderController.start();
    loaderController.setRefreshing();
    final tariffs = (await tariffUC.getAll(ws.id!)).sorted((t1, t2) => compareNatural('$t1', '$t2')).sorted((t1, t2) => t1.tier.compareTo(t2.tier));
    await loaderController.stop();
    if (tariffs.isNotEmpty) {
      final tariff = await tariffSelectDialog(tariffs, ws.id!);
      if (tariff != null) {
        loaderController.start();
        loaderController.setSaving();
        final signedContractInvoice = await contractUC.sign(tariff.id!, ws.id!);
        if (signedContractInvoice != null) {
          ws.invoice = signedContractInvoice;
        }
        await loaderController.stop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MTPage(
      navBar: navBar(context, title: loc.tariff_current_title, bgColor: backgroundColor),
      body: SafeArea(
        // top: false,
        // bottom: false,
        child: TariffInfo(ws.invoice.tariff),
      ),
      bottomBar: MTButton.outlined(
        titleText: loc.tariff_change_action_title,
        onTap: () => _changeTariff(context),
        margin: const EdgeInsets.symmetric(horizontal: P),
      ),
    );
  }
}
